//
//  StartView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView{
            List {
                NavigationLink{
                    ContentView()
                } label: {
                    StartList(color: .red, titletext: "Start Game", imagename: "darts", useSFSymbol: false)
                }
                NavigationLink{
                    ContentView()
                } label: {
                    StartList(color: .yellow, titletext: "Data", imagename: "list.number", useSFSymbol: true)
                }
                NavigationLink{
                    ContentView()
                } label: {
                    StartList(color: .blue, titletext: "Settings", imagename: "gear", useSFSymbol: true)
                }
            }
            .navigationTitle("Smokin' DARTS")
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
