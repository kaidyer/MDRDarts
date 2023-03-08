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
        let Player1 = viewModel.score[0]
        let Player2 = viewModel.score[1]
        let recScores = viewModel.recScores
        let p1score = viewModel.p1score
        let p2score = viewModel.p2score
        VStack {
            Text("Smokin' D.A.R.T.S")
                .font(.title)
                .fontWeight(.bold)
            let colors = viewModel.colors
            ZStack {
                ForEach(colors) {
                    color in SegmentView(color: color)
                }
                Circle()
                    .stroke(.black)
                    .background(Circle().fill(viewModel.centerColors[0]))
                    .frame(width: 50)
                Circle()
                    .stroke(.black)
                    .background(Circle().fill(viewModel.centerColors[1]))
                    .frame(width: 25)
            }
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.red)
                        .frame(width: 150, height: 150)
                    ScoreView(score: Player1, playerID: 1)
                }.offset(x: 20)
                VStack {
                    CurrentPlayer(whichPlayer: viewModel.whichPlayer)
                    Text("Score")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.blue)
                        .frame(width: 150, height: 150)
                    ScoreView(score: Player2, playerID: 2)
                }.offset(x: -20)
            }
            Text("Recommended Throws")
                .font(.title)
                .padding(.top)
            RecView(recScores: recScores, player1Score: p1score, player2Score: p2score)
            Spacer()
            HStack{
                Text("Connect")
                    .onTapGesture {
                        viewModel.viewDidLoad()
                        //viewModel.subscribe()
                    }
                Text("Subscribe")
                    .onTapGesture {
                        viewModel.subscribe()
                    }
            }
            Text("Reset")
                .onTapGesture {
                    viewModel.resetGame()
                }
            }
        }
        
    }

struct CurrentPlayer: View {
    var whichPlayer: Int
    
    var body: some View {
        // let rectColor: Color
        ZStack{
            if whichPlayer == 1 {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red)
                    .frame(width: 150, height: 50)
            }
            else {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.blue)
                    .frame(width: 150, height: 50)
            }
            if whichPlayer == 1 {
                Text("Player 1's Turn")
                    .font(.headline)
            }
            else {
                Text("Player 2's Turn")
                    .font(.headline)
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
    var player1Score: Int
    var player2Score: Int
    
    var body: some View {
        HStack{
            Spacer()
            if (Int(player1Score) == 0) {
                Text("Player 1 wins!")
            }
            else {
                if let recommendedText1 = recScores[player1Score] {
                    Text(recommendedText1)
                }
                else {
                    let recommendedText1 = "No Checkout"
                    Text(recommendedText1)
                }
            }
            
            Spacer()
            
            if (Int(player2Score) == 0) {
                Text("Player 2 wins!")
            }
            else {
                if let recommendedText2 = recScores[player2Score] {
                    Text(recommendedText2)
                }
                else {
                    let recommendedText2 = "No Checkout"
                    Text(recommendedText2)
                }
            }
            Spacer()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
