//
//  ContentView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//
// FONT NAMES
// MakeupPersonalUse-Regular
// Metalsmith-Regular
// CinderelaPersonalUse-Regular

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    @State private var user = ""
    @EnvironmentObject var appState: AppState
    
    @StateObject private var viewModel = DartsViewModel()
    // @EnvironmentObject private var viewModel: DartsViewModel
    
    
    var body: some View {
        let Player1 = viewModel.score[0]
        let Player2 = viewModel.score[1]
        let recScores = viewModel.recScores
        let p1score = viewModel.p1score
        let p2score = viewModel.p2score
        VStack(spacing: 0) {
            Spacer()
//            Text("  Smokin' D.A.R.T.S  ")
//                .font(.custom("MakeupPersonalUse-Regular", size: 35))
//                .font(.custom("Metalsmith-Regular", size: 35))
//                .fontWeight(.bold)
//                .offset(y: 50)
            let colors = viewModel.colors
            ZStack {
                Image("dartboard2")
                    .resizable()
                    .frame(width: 550, height: 550)
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
            }.offset(y: -20)
            HStack{
                ScoreView(score: Player1, playerID: 1).offset(x: 20)
                Spacer()
                VStack {
                    CurrentPlayer(whichPlayer: viewModel.whichPlayer, p1score: p1score, p2score: p2score)
                    Text("Score")
                        .font(.custom("Metalsmith-Regular", size: 30))
                        .fontWeight(.bold)
                }
                Spacer()
                ScoreView(score: Player2, playerID: 2).offset(x: -20)
            }.offset(y: -90)
            RecView(recScores: recScores, player1Score: p1score, player2Score: p2score)
                .offset(y: -60)
            Spacer()
            HStack{
                Text("Connect")
                    .font(.custom("Metalsmith-Regular", size: 15))
                    .onTapGesture {
                        viewModel.viewDidLoad()
                        //viewModel.subscribe()
                    }
                Text("Subscribe")
                    .font(.custom("Metalsmith-Regular", size: 15))
                    .onTapGesture {
                        viewModel.subscribe()
                    }
            }.offset(y: -60)
            Text("Reset")
                .font(.custom("Metalsmith-Regular", size: 15))
                .padding(.bottom)
                .onTapGesture {
                    viewModel.resetGame()
                }.offset(y: -60)
            Spacer()
        }.background(Image("wood").resizable().aspectRatio(contentMode: .fill).offset(y: -50))
    }
        
}

struct CurrentPlayer: View {
    var whichPlayer: Int
    var p1score: Int
    var p2score: Int
    
    let width: CGFloat = 105
    let height: CGFloat = 30
    let radius: CGFloat = 15
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.gray)
                .frame(width: width+5, height: height+5)
                .offset(x: 2.5, y: 2.5)
            if (p1score == 0) || (p2score == 0) {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(.yellow)
                    .frame(width: width, height: height)
            }
            else if whichPlayer == 1 {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(.red)
                    .frame(width: width, height: height)
            }
            else {
                RoundedRectangle(cornerRadius: radius, style: .continuous)
                    .fill(.blue)
                    .frame(width: width, height: height)
            }
            if p1score == 0 {
                Text("Player 1 wins!")
                    .font(.custom("Metalsmith-Regular", size: 15))
            }
            else if p2score == 0 {
                Text("Player 2 wins!")
                    .font(.custom("Metalsmith-Regular", size: 15))
            }
            else if whichPlayer == 1 {
                Text("Player 1's Turn")
                    .font(.custom("Metalsmith-Regular", size: 15))
            }
            else {
                Text("Player 2's Turn")
                    .font(.custom("Metalsmith-Regular", size: 15))
            }
        }
    }
}
    
struct ScoreView: View {
    var score: DartsGame.Score
    var playerID: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.gray)
                .frame(width: 110, height: 110)
                .offset(x: 2.5, y: 2.5)
            if playerID == 1 {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.red)
                    .frame(width: 105, height: 105)
            }
            else {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(.blue)
                    .frame(width: 105, height: 105)
            }
            VStack{
                Text("Player \(playerID)")
                    .font(.custom("Metalsmith-Regular", size: 20))
                    .offset(y: 10)
                Text(String(score.score))
                    .font(.custom("Metalsmith-Regular", size: 50))
                    .fontWeight(.bold)
            }
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
                    .font(.custom("Metalsmith-Regular", size: 25))
            }
            else {
                if let recommendedText1 = recScores[player1Score] {
                    Text(recommendedText1)
                        .font(.custom("Metalsmith-Regular", size: 25))
                }
                else {
                    let recommendedText1 = "No Checkout"
                    Text(recommendedText1)
                        .font(.custom("Metalsmith-Regular", size: 25))
                }
            }
            
            Spacer()
            
            if (Int(player2Score) == 0) {
                Text("Player 2 wins!")
                    .font(.custom("Metalsmith-Regular", size: 25))
            }
            else {
                if let recommendedText2 = recScores[player2Score] {
                    Text(recommendedText2)
                        .font(.custom("Metalsmith-Regular", size: 25))
                }
                else {
                    let recommendedText2 = "No Checkout"
                    Text(recommendedText2)
                        .font(.custom("Metalsmith-Regular", size: 25))
                }
            }
            Spacer()
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 14")
    }
}
