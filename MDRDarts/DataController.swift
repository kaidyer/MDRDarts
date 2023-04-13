//
//  DataController.swift
//  MDRDarts
//
//  Created by Kai Dyer on 4/4/23.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Dart")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func editUser(user: User, totalScore: Int16, context: NSManagedObjectContext) {
        user.totalScore += totalScore
        user.numberThrows += 1
        //user.averageScore = user.totalScore / user.numberThrows
        //user.name = "Gotcha"
        
        save(context: context)
    }
}
