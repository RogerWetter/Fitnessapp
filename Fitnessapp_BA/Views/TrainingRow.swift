//
//  TrainingRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI

struct TrainingRow: View {
  
  let training: Training
  @State private var isShowingExerciseView = false
  
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        MuscleGroupRow(muscleGroups: training.uniqueMuscleGroups)
        Text(training.name).font(.title)
        if (training.Exercises.count == 1) {
          Text("One Exercise")
        } else {
          Text("\(training.Exercises.count) Exercises")
        }
      }
    }
    .sheet(isPresented: $isShowingExerciseView) {
      EmptyView()
    }
  }
  
  private func startTraining() {
    isShowingExerciseView = true
  }
  
}


// #Preview {
//   TrainingRow(training: Training())
//     .modelContainer(for: Training.self, inMemory: true)
// }

