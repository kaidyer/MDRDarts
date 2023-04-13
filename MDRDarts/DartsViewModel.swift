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
//    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    typealias Score = DartsGame.Score
    
    private static let startingScore = 201

    private static func createDartsGame() -> DartsGame {
        DartsGame(scores: startingScore)
    }

    @Published private var model: DartsGame = createDartsGame()
    
    
    func resetGame() {
        model.re_init(scores: 201)
    }
    
    @Published var currentUser = ""
    
    var score: Array<Score> {
        return model.scores
    }
    
    var winner: Int {
        return model.winner
    }
    
    var whichPlayer: Int {
        return model.whichPlayer
    }
    
    var throwCount: Int {
        return model.throwCount
    }
    
    var recScores: [Int: String] {
        return model.recScores
    }
    
    var oldscore1 = 201
    var oldscore2 = 201
    
    var times:[Double] = []
    
    var p1score: Int {
        if throwCount == 1{
            oldscore1 = score[0].score
        }
        return oldscore1
    }
    
    var p2score: Int {
        if throwCount == 1{
            oldscore2 = score[1].score
        }
        return oldscore2
    }
    
    func lower(_ score: Score, amt: Int) {
        model.lower(score: score, amt: amt)
    }
    
    // MARK: - DARTBOARD FUNCTIONS
    
    let startAngles1: [Double] = [63, 27, -9, -45, -81, -117, -153, -189, -225, -261]
    let startAngles2: [Double] = [81, 45, 9, -27, -63, -99, -135, -171, -207, -243]
    
    let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
    let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
    
    var colors: [colorList] {
        return model.colors
    }
    
    var centerColors: [Color] {
        return model.centerColors
    }
    
    func getSegment(id: Int) -> colorList? {
        for color in model.colors {
            if color.id == id {
                return color
            }
        }
        return nil
    }
    
    func setYellow(slice: Int, block: Int) {
        let index: Int
        switch slice{
        case 20:
            index = 0
        case 1:
            index = 1
        case 18:
            index = 2
        case 4:
            index = 3
        case 13:
            index = 4
        case 6:
            index = 5
        case 10:
            index = 6
        case 15:
            index = 7
        case 2:
            index = 8
        case 17:
            index = 9
        case 3:
            index = 10
        case 19:
            index = 11
        case 7:
            index = 12
        case 16:
            index = 13
        case 8:
            index = 14
        case 11:
            index = 15
        case 14:
            index = 16
        case 9:
            index = 17
        case 12:
            index = 18
        case 5:
            index = 19
        default:
            index = 0
        }
        model.colors[index].colors[block] = Color(.yellow)
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
        session?.password = "Green82"
        
        session?.connect()
    }
    
    func subscribe() {
        session?.subscribe(toTopic: "darts", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "0", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "11", at: .exactlyOnce) { error, result in
            print("subscribe result error \(String(describing: error)) result \(result!)")
        }
        session?.subscribe(toTopic: "12", at: .exactlyOnce) { error, result in
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
    
    func updateData(score: Int) {
//        for user in users {
//            if user.name == currentUser {
//                DataController().editUser(user: user, totalScore: Int16(score), context: moc)
//            }
//        }
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
            let now = Date()
            times.append(now.timeIntervalSince1970)
            print("\(now.timeIntervalSince1970), ")
            print(times)
            if (modifier == -1) || (subInt == -1) {
                print("topic \(topic!), msg \(msg)")
            }
            else {
                if whichPlayer == 1 {
                    if throwCount <= 3 {
                        if modifier == Int(11) || modifier == Int(12) {
                            lower(score[0], amt: subInt)
                            //updateData(score: subInt)
                        } else {
                            lower(score[0], amt: modifier * subInt)
                            //updateData(score: modifier*subInt)
                        }
                        print("modifier \(modifier), subtracting \(subInt)")
                        model.throwCount = throwCount + 1
                        
                        if subInt == Int(25) {
                            model.centerColors[0] = Color(.yellow)
                        } else if subInt == Int(50) {
                            model.centerColors[1] = Color(.yellow)
                        } else {
                            switch modifier {
                            case 11:
                                setYellow(slice: subInt, block: 1)
                            case 12:
                                setYellow(slice: subInt, block: 3)
                            case 2:
                                setYellow(slice: subInt, block: 0)
                            case 3:
                                setYellow(slice: subInt, block: 2)
                            default:
                                setYellow(slice: subInt, block: 1)
                            }
                        }
                        
                    }
                    if throwCount > 3 {
                        model.whichPlayer = 2
                        model.throwCount = 1
                        model.reset_colors()
                    }
                }
                else {
                    if throwCount <= 3 {
                        if modifier == Int(11) || modifier == Int(12) {
                            lower(score[1], amt: subInt)
                        } else {
                            lower(score[1], amt: modifier * subInt)
                            
                        }
                        
                        print("modifier \(modifier), subtracting \(subInt)")
                        model.throwCount = throwCount + 1
                        
                        if subInt == Int(25) {
                            model.centerColors[0] = Color(.yellow)
                        } else if subInt == Int(50) {
                            model.centerColors[1] = Color(.yellow)
                        } else {
                            switch modifier {
                            case 11:
                                setYellow(slice: subInt, block: 1)
                            case 12:
                                setYellow(slice: subInt, block: 3)
                            case 2:
                                setYellow(slice: subInt, block: 0)
                            case 3:
                                setYellow(slice: subInt, block: 2)
                            default:
                                setYellow(slice: subInt, block: 1)
                            }
                        }
                    }
                    if throwCount > 3 {
                        model.whichPlayer = 1
                        model.throwCount = 1
                        model.reset_colors()
                    }
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

