//
//  Fitnessapp_BAApp.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI
import SwiftData

@main
struct Fitnessapp_BAApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Training.self,
            Exercise.self,
            SavedExercise.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//        let modelConfiguration = ModelConfiguration("DataContainer", schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
  
  init() {
    print(URL.applicationSupportDirectory.path(percentEncoded: false))
  }
}
