//
//  DartsGame.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//

import Foundation
import MQTTClient

struct DartsGame {
    var scores: Array<Score>
    var winner = 0
    var mqttModel = MQTTModel()
    var message: String?
    
    init(scores: Int) {
        self.scores = []
        self.winner = 0
        
        self.scores.append(Score(score: scores, id: 1))
        self.scores.append(Score(score: scores, id: 2))
    }
    
    mutating func lower(score: Score, amt: Int) {
        if let chosenIndex = scores.firstIndex(where: {$0.id == score.id }) {
            if scores[chosenIndex].score - amt < 0 {
                return
            }
            else if scores[chosenIndex].score - amt == 0 {
                scores[chosenIndex].score = 0
                winner = scores[chosenIndex].id
            }
            else {
                scores[chosenIndex].score = scores[chosenIndex].score - amt
            }
        }
    }
    
    mutating func re_init(scores: Int) {
        self.scores = []
        self.scores.append(Score(score: scores, id: 1))
        self.scores.append(Score(score: scores, id: 2))
        self.winner = 0
    }
    
    func viewDidLoad() {
        mqttModel.viewDidLoad()
    }
    
    func subscribe() {
        mqttModel.subscribe()
    }
    
    func publishMessage(msg: String, top: String) {
        mqttModel.publishMessage(msg, onTopic: top)
    }
    
    mutating func lower1() {
        lower(score: scores[0], amt: 10)
    }
    
    struct Score: Identifiable {
        var score: Int
        var id: Int
    }
}

class MQTTModel: NSObject {
    
    let MQTT_HOST = "192.168.1.160" // or IP address e.g. "192.168.0.194"
    let MQTT_PORT: UInt32 = 1883
    var transport = MQTTCFSocketTransport()
    var session = MQTTSession()
    var completion: (()->())?
    
    
    func viewDidLoad() {
        
        self.session?.delegate = self
        self.transport.host = MQTT_HOST
        self.transport.port = MQTT_PORT
        session?.transport = transport
        
        session?.connect()
    }
    
    func subscribe() {
        session?.subscribe(toTopic: "darts", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
    }
    
    func publishMessage(_ message: String, onTopic topic: String) {
        session?.publishData(message.data(using: .utf8, allowLossyConversion: false), onTopic: topic, retain: false, qos: .exactlyOnce)
    }
}

extension MQTTModel: MQTTSessionManagerDelegate, MQTTSessionDelegate {
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
        if let msg = String(data: data, encoding: .utf8) {
            print("topic \(topic!), msg \(msg)")
        }
        
    }

    func messageDelivered(_ session: MQTTSession, msgID msgId: UInt16) {
        print("delivered")
        DispatchQueue.main.async {
            self.completion?()
        }
    }
}
