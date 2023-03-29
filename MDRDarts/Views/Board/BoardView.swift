//
//  BoardView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/26/23.
//

import SwiftUI

struct BoardView: View {
    @StateObject private var viewModel = BoardViewModel()
    
    var body: some View {
        
        let colors = viewModel.colors
        let myRed = Color(red: 0.843, green: 0.0784, blue: 0.08627)
        let myGreen = Color(red: 0.0235, green: 0.4509, blue: 0.1098)
        ZStack {
            Image("dartboard2")
                .resizable()
                .frame(width: 550, height: 550)
            ForEach(colors) {
                color in SegmentView(color: color)
            }
            Circle()
                .stroke(.black)
                .background(Circle().fill(myGreen))
                .frame(width: 50)
            Circle()
                .stroke(.black)
                .background(Circle().fill(myRed))
                .frame(width: 25)
        }.onTapGesture {
            viewModel.setYellow(slice: 16, block: 1)
            viewModel.setYellow(slice: 20, block: 3)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
