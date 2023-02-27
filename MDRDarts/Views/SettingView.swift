//
//  SettingView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct SettingView: View {
    @State var gameType: Int
    @State var trackStats: Bool
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Settings")) {
                    Picker("Game Type", selection: $gameType){
                        Text("201").tag(0)
                        Text("501").tag(1)
                    }
                    Toggle("Track My Stats", isOn: $trackStats)
                    Button("Clear My Stats") {}
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(gameType: 0, trackStats: true)
    }
}
