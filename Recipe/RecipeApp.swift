//
//  RecipeApp.swift
//  Recipe
//
//  Created by roman on 22.11.2024.
//

import SwiftUI
let persistenceController = PersistenceController.shared

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
