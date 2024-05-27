//
//  SetRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct ActiveSetRow: View {
  
  @Binding var exercise: Exercise
  
  @State var isEditing = true
  @State var isNumberPickerWheelActiveWeight = false
  @State var isNumberPickerWheelActiveRepetitions = false
  
  var body: some View {
    
    HStack {
      ActiveTrainingEditNumberButton( number: $exercise.weight, isEditing: $isEditing, unit: "kg")
      ActiveTrainingEditNumberButton(number: $exercise.repetitions, isEditing: $isEditing, sysImage: "arrow.clockwise")
//      ActiveTrainingEditNumberButton(number: $setTime, isEditing: $isEditing, sysImage: "clock.arrow.2.circlepath")
      ActiveTrainingEditNumberButton(number: $exercise.setPause, isEditing: $isEditing, sysImage: "pause")

    }
  }
}

#Preview {
  ActiveSetRow(exercise: .constant(Exercise(name: "Name", device: nil, weight: 55, repetitions: 10, sets: 3, setPause: 3, setTime: 3, image: nil)))
    .modelContainer(for: Training.self, inMemory: true)
}
