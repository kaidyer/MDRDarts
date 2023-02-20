//
//  ContentView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DartsViewModel()
    var body: some View {
        var Player1 = viewModel.score[0]
        var Player2 = viewModel.score[1]
        let recScores = viewModel.recScores
        VStack {
            Text("Smokin' D.A.R.T.S")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Text("Score")
                .font(.largeTitle)
                .fontWeight(.bold)
            HStack{
                ScoreView(score: Player1, playerID: 1)
                Spacer()
                ScoreView(score: Player2, playerID: 2)
            }
            HStack{
                Text("Connect")
                    .onTapGesture {
                        viewModel.viewDidLoad()
                        // viewModel.subscribe()
                    }
                Text("Subscribe")
                    .onTapGesture {
                        viewModel.subscribe()
                    }
//                Text("Send a message")
//                    .onTapGesture {
//                        viewModel.publishMessage("Hello from iPhone", onTopic: "darts")
//                    }
            }
//            Text("lower")
//                .onTapGesture {
//                    viewModel.lower(Player1, amt: 10)
//                    viewModel.lower(Player2, amt: 15)
//                }
            Text("Recommended Throws")
                .font(.title)
                .padding(.top)
            RecView(recScores: recScores, player1: Player1, player2: Player2)
            Spacer()
            Text("Reset")
                .onTapGesture {
                    viewModel.resetGame()
                }
            
        }
    }
}

struct ScoreView: View {
    var score: DartsGame.Score
    var playerID: Int
    
    var body: some View {
        VStack{
            Text("Player \(playerID)")
                .font(.system(size: 25))
            Text(String(score.score))
                .font(.system(size: 40))
                .fontWeight(.bold)
        }
        
    }
}

struct RecView: View {
    var recScores: [Int: String]
    var player1: DartsGame.Score
    var player2: DartsGame.Score
    
    var body: some View {
        let player1Score = player1.score
        let player2Score = player2.score
        HStack{
            if (player1Score == 0) {
                Text("Player 1 wins!")
            }
            else {
                if let recommendedText1 = recScores[player1Score] {
                    Text(recommendedText1)
                }
                else {
                    let recommendedText1 = "Reach a lower score first."
                    Text(recommendedText1)
                }
            }
            
            Spacer()
            
            if (player2Score == 0) {
                Text("Player 2 wins!")
            }
            else {
                if let recommendedText2 = recScores[player2Score] {
                    Text(recommendedText2)
                }
                else {
                    let recommendedText2 = "Reach a lower score first."
                    Text(recommendedText2)
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
