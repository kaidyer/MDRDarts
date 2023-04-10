//
//  DataView.swift
//  MDRDarts
//
//  Created by Kai Dyer on 2/23/23.
//

import SwiftUI

struct DataView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
    
    @State private var user = ""
    @State private var showingAddScreen = false
    
    @StateObject private var viewModel = DataViewModel()
    
    
    var body: some View {
        List {
            Section(header: Text("User")) {
                Picker("User", selection: $user) {
                    ForEach(users.map { $0.name! }, id: \.self) {
                        Text($0)
                    }
                }
            }
//            Section(header: Text("\(user) Data")) {
//                for people in users {
//                    if people.name == user {
//                        Text(people.numberThrows)
//                    }
//                }
//            }
            Section(header: Text("Delete All")) {
                Button("Delete All Users") {
                    for user in users {
                        moc.delete(user)
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddScreen.toggle()
                } label: {
                    Label("Add Book", systemImage: "plus")
                }
            }

        }
        .sheet(isPresented: $showingAddScreen) {
            AddBookView()
        }

        
    }
}

struct DataView_Previews: PreviewProvider {
    static var previews: some View {
        DataView()
    }
}
