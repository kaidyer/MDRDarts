//
//  DataView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct DataView: View {
    var body: some View {
        List {
            Text("Accuracy")
            Text("Points Scored")
            Text("Points Scored Against You")
            Text("Wins")
            Text("Losses")
            Text("Win/Loss Ratio")
        }
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
