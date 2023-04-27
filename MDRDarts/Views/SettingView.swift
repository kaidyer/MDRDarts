//
//  SettingView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

class AppState: ObservableObject {
    @Published var startingScore: Int
    @Published var trackStats: Bool
    
    init(startingScore: Int = 501, trackStats: Bool = true) {
            self.startingScore = startingScore
            self.trackStats = trackStats
    }
}

struct SettingView: View {
//    @State var gameType: Int
//    @State var trackStats: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Game Settings")) {
                    Picker("Game Type", selection: $appState.startingScore){
                        Text("201").tag(0)
                        Text("501").tag(1)
                    }
                    Toggle("Track My Stats", isOn: $appState.trackStats)
                    Button("Clear My Stats") {}
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(AppState())
    }
}
