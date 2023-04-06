//
//  AddBookView.swift
//  Bookworm
//
//  Created by Paul Hudson on 23/11/2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var name = ""

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of user", text: $name)
                }
                Section {
                    Button("Save") {
                        let newBook = User(context: moc)
                        newBook.id = UUID()
                        newBook.name = name
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add a User")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
