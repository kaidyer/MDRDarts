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
        VStack {
            Spacer()
            Text("Smokin' D.A.R.T.S")
                .font(.title)
                .fontWeight(.bold)
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
                    }
                Text("Subscribe")
                    .onTapGesture {
                        viewModel.subscribe()
                    }
                Text("Send a message")
                    .onTapGesture {
                        viewModel.publishMessage("Hello from iPhone", onTopic: "darts")
                    }
            }
            Text("Print Received Message")
                .onTapGesture {
                    if let message = viewModel.message {
                        print("The message was \(message)")
                    }
                }
            Text("lower")
                .onTapGesture {
                    print("Score is \(viewModel.score[0].score)")
                    viewModel.lower(Player1, amt: 10)
                    print("Score is now \(viewModel.score[0].score)")
                }
            Spacer()
            
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
