//
//  ExerciseRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 30.04.2024.
//

import SwiftUI

struct ExerciseRow: View {
  
  let exercise: Exercise
  
  var body: some View {
    HStack {
      VStack {
        HStack {
          ForEach(exercise.muscleGroups) { muscleGroup in
            Text(muscleGroup.name)
          }
          
        }
        Text(exercise.name).font(.title)
      }
    }
  }
}

//#Preview {
//  ExerciseRow(exercise: Exercise())
//    .modelContainer(for: Exercise.self, inMemory: true)
//}
