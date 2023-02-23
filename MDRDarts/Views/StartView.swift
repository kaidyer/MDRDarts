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
            NavigationLink{
                ContentView()
            } label: {
                Text("Start")
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
