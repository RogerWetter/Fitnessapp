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
    HStack(alignment: .center) {
      VStack(alignment: .leading) {
        HStack {
          if let device = exercise.device {
            Text(device)
              .font(.caption)
          }
          MuscleGroupRow(muscleGroups: exercise.muscleGroups)
        }
        Text(exercise.name).font(.title)
        HStack {
          if let weight = exercise.weight {
            Text("\(weight) kg")
              .font(.caption)
          }
          if let repetitions = exercise.repetitions {
            Text("\(repetitions) \(Image(systemName: "arrow.clockwise"))")
              .font(.caption)
          }
          if let sets = exercise.sets {
            Text("\(sets) \(Image(systemName: "arrow.triangle.2.circlepath"))")
              .font(.caption)
          }
          if let setTime = exercise.setTime {
            Text("\(setTime)' \(Image(systemName: "clock.arrow.2.circlepath"))")
              .font(.caption)
          }
          if let setPause = exercise.setPause {
            Text("\(setPause)' \(Image(systemName: "pause"))")
              .font(.caption)
          }
          
        }
      }
      Spacer()
      if let image = exercise.image {
        Image(uiImage: UIImage(data: image)!)
          .resizable()
          .frame(width: 100, height: 100)
          .cornerRadius(10)
      }
      
      
    }
  }
}

#Preview {
  ExerciseRow(exercise: Exercise(name: "Brustpresse", device: "E10", weight: 70, muscleGroup: [], repetitions: 10, sets: 55, setPause: 3, setTime: 3, image: UIImage(named: "Brustzug")?.pngData()))
    .modelContainer(for: Exercise.self, inMemory: true)
}
