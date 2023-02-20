//
//  DartsViewModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//

import Foundation
import SwiftUI
import MQTTClient

class DartsViewModel: NSObject, ObservableObject, MQTTSessionDelegate, MQTTSessionManagerDelegate {
    typealias Score = DartsGame.Score
    
    private static let startingScore = 201

    private static func createDartsGame() -> DartsGame {
        DartsGame(scores: startingScore)
    }

    @Published private var model: DartsGame = createDartsGame()
    
    
    func resetGame() {
        model.re_init(scores: 201)
    }
    
    var score: Array<Score> {
        return model.scores
    }
    
    var winner: Int {
        return model.winner
    }
    
    var whichPlayer: Int {
        return model.whichPlayer
    }
    
    var recScores: [Int: String] {
        return model.recScores
    }
    
    func lower(_ score: Score, amt: Int) {
        model.lower(score: score, amt: amt)
    }
    
    // MARK: - MQTT Functions
    // let MQTT_HOST = "192.168.1.176" // or IP address e.g. "192.168.0.194"
    //let MQTT_HOST = "172.31.29.164" // or IP address e.g. "192.168.0.194"
    let MQTT_HOST = "broker.emqx.io"
    //let MQTT_HOST = "broker.hivemq.com"
    let MQTT_PORT: UInt32 = 1883
    var transport = MQTTCFSocketTransport()
    var session = MQTTSession()
    var completion: (()->())?
    var message: String?
    
    
    func viewDidLoad() {
        
        self.session?.delegate = self
        self.transport.host = MQTT_HOST
        self.transport.port = MQTT_PORT
        session?.transport = transport
        session?.userName = "kdyer"
        session?.password = "Green"
        
        session?.connect()
    }
    
    func subscribe() {
        session?.subscribe(toTopic: "darts", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "0", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "1", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "2", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "3", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
    }
    
    func publishMessage(_ message: String, onTopic topic: String) {
        session?.publishData(message.data(using: .utf8, allowLossyConversion: false), onTopic: topic, retain: false, qos: .exactlyOnce)
    }
}

extension DartsViewModel {
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        if let msg = String(data: data, encoding: .utf8) {
            let subInt = Int(msg) ?? -1
            let modifier = Int(topic) ?? -1
            print("topic \(topic!)")
            // cases:
            // topic: Int, msg: Int
            // topic: Str, msg: Int
            // topic: Int, msg: Str
            // topic: Str, msg: Str
            if (modifier == -1) || (subInt == -1) {
                print("topic \(topic!), msg \(msg)")
            }
            else {
                if whichPlayer == 1 {
                    lower(score[0], amt: modifier * subInt)
                    model.whichPlayer = 2
                    print("modifier \(modifier), subtracting \(subInt)")
                }
                else {
                    lower(score[1], amt: modifier * subInt)
                    model.whichPlayer = 1
                    print("modifier \(modifier), subtracting \(subInt)")
                }
            }
        }
        
    }

    func messageDelivered(_ session: MQTTSession, msgID msgId: UInt16) {
        print("delivered")
        DispatchQueue.main.async {
            self.completion?()
        }
    }
}

