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
        ZStack {
            ForEach(colors) {
                color in SegmentView(color: color)
            }
            Circle()
                .stroke(.black)
                .background(Circle().fill(.green))
                .frame(width: 50)
            Circle()
                .stroke(.black)
                .background(Circle().fill(.red))
                .frame(width: 25)
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
