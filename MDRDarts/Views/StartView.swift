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
    
    //@StateObject private var viewModel = DartsViewModel()
    
    var body: some View {
        VStack {
            Text("Smokin' DARTS")
                .font(.custom("Metalsmith-Regular", size: 35))
            NavigationView{
                List {
                    NavigationLink{
                        ContentView()
                            .environmentObject(AppState())
                    } label: {
                        StartList(color: .red, titletext: "Start Darts", imagename: "darts", useSFSymbol: false)
                    }
                    NavigationLink{
                        DataView()
                    } label: {
                        StartList(color: .yellow, titletext: "Data", imagename: "list.number", useSFSymbol: true)
                    }
                    NavigationLink{
                        SettingView()
                            .environmentObject(AppState())
                    } label: {
                        StartList(color: .blue, titletext: "Settings", imagename: "gear", useSFSymbol: true)
                    }
                    NavigationLink{
                        Home()
                    } label: {
                        StartList(color: .green, titletext: "How to Play", imagename: "studentdesk", useSFSymbol: true)
                    }
                }
//                .navigationBarTitle(Text("Smokin' DARTS").font(.custom("Metalsmith-Regular", size: 35)))
            }            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
