//
//  ExerciseRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 30.04.2024.
//

import SwiftUI

struct ExerciseRowActiveTraining: View {
  
  let exercise: Exercise
  let status: SavedExercise?
  
  var calculatedStatus: Double {
    let totalWeightAndReps = status?.sets.reduce(0) { result, set in
      return result + (set.weight ?? 0) * (set.repetitions ?? 0)
    } ?? 0
    
    // Assuming you have a total target weight and reps, calculate the progress
    let totalTargetWeightAndReps = (status?.exercise?.weight ?? 1) * (status?.exercise?.repetitions ?? 1) * (status?.exercise?.sets ?? 1)
    
    return Double(totalWeightAndReps) / Double(totalTargetWeightAndReps)
  }
  
  var body: some View {
    VStack {
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
          Text("Status: \(Int(calculatedStatus * 100)) %")
        }
        Spacer()
        if let image = exercise.image {
          Image(uiImage: UIImage(data: image)!)
            .resizable()
            .frame(width: 100, height: 100)
            .cornerRadius(10)
        }
      }
      ProgressView(value: min(calculatedStatus, 1))
        .tint(calculatedStatus < 1 ? .orange : .blue)
      if calculatedStatus > 1 {
        ProgressView(value: calculatedStatus.truncatingRemainder(dividingBy: Double(1)))
          .tint(.green)
      }
    }
  }
}
//
//#Preview {
//  ExerciseRowActiveTraining(exercise: Exercise(name: "Brustpresse", device: "E10", weight: 70, muscleGroup: [], repetitions: 10, setPause: 3, setTime: 3, image: UIImage(named: "Brustzug")?.pngData()), status: SavedExercise(exercise: Exercise(name: "Brustpresse", device: "E10", weight: 70, muscleGroup: [], repetitions: 10, setPause: 3, setTime: 3, image: nil), sets: [SavedSet(weight: 70, repetitions: 10, setPause: nil, setTime: nil)]))
//    .modelContainer(for: Exercise.self, inMemory: true)
//}
