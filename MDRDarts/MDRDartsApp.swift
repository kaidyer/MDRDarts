//
//  MDRDartsApp.swift
//  MDRDarts
//
//  Created by Kai Dyer on 12/5/22.
//

import SwiftUI

@main
struct MDRDartsApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            // ContentView()
            StartView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
