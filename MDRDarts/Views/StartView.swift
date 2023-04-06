//
//  StartView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct StartView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    var body: some View {
        VStack {
            NavigationView{
                List {
                    NavigationLink{
                        ContentView()
                    } label: {
                        StartList(color: .red, titletext: "Start Darts", imagename: "darts", useSFSymbol: false)
                    }
                    NavigationLink{
                        DataView()
                    } label: {
                        StartList(color: .yellow, titletext: "Data", imagename: "list.number", useSFSymbol: true)
                    }
                    NavigationLink{
                        SettingView(gameType: 1, trackStats: true)
                    } label: {
                        StartList(color: .blue, titletext: "Settings", imagename: "gear", useSFSymbol: true)
                    }
                    NavigationLink{
                        TutorialView()
                    } label: {
                        StartList(color: .green, titletext: "How to Play", imagename: "studentdesk", useSFSymbol: true)
                    }
                }
                .navigationTitle("Smokin' DARTS")
            }            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
