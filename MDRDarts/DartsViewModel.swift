//
//  DartsViewModel.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//

import Foundation
import SwiftUI

class DartsViewModel: ObservableObject {
    typealias Score = DartsGame.Score
    
    private static let startingScore = 501

    private static func createDartsGame() -> DartsGame {
        DartsGame(scores: startingScore)
    }

    @Published private var model: DartsGame = createDartsGame()
    
    
    func resetGame() {
        model.re_init(scores: 501)
    }
    
    var score: Array<Score> {
        return model.scores
    }
    
    var winner: Int {
        return model.winner
    }
    
    var message: String? {
        return model.message
    }
    
    func lower(_ score: Score, amt: Int) {
        model.lower(score: score, amt: amt)
    }
    
    func subscribe() {
        model.subscribe()
    }
    
    func connect() {
        model.viewDidLoad()
    }
    
    func sendMessage(msg: String, top: String) {
        model.publishMessage(msg: msg, top: top)
    }
}
