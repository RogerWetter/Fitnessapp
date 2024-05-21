//
//  PreviewContainer.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 21.05.2024.
//

import Foundation
import SwiftData

struct Preview {
  let container: ModelContainer
  init() {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    do {
      container = try ModelContainer(for: SavedExercise.self, configurations: config)
    } catch {
      fatalError("Could not create preview Container, error: \(error.localizedDescription)")
    }
  }
  
  func addExamples(_ examples: [SavedExercise]) {
    Task { @MainActor in
      examples.forEach { example in
        container.mainContext.insert(example)
      }
    }
  }
}
