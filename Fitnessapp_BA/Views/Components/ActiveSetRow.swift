//
//  SetRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct ActiveSetRow: View {
  
  @Bindable var training: Training
  @Binding var activeExercise: Int
  @Binding var weight: Int?
  @Binding var repetitions: Int?
  //  @Binding var setTime: Int?
  @Binding var setPause: Int?
  
  @State var isEditing = true
  @State var isNumberPickerWheelActiveWeight = false
  @State var isNumberPickerWheelActiveRepetitions = false
  
  var body: some View {
    
    HStack {
      ActiveTrainingEditNumberButton(number: $weight, isEditing: $isEditing, unit: "kg")
      ActiveTrainingEditNumberButton(number: $repetitions, isEditing: $isEditing, sysImage: "arrow.clockwise")
//      ActiveTrainingEditNumberButton(number: $setTime, isEditing: $isEditing, sysImage: "clock.arrow.2.circlepath")
      ActiveTrainingEditNumberButton(number: $setPause, isEditing: $isEditing, sysImage: "pause")

    }
    .onAppear(perform: {
      weight = training.exercises[activeExercise].weight
      repetitions = training.exercises[activeExercise].repetitions
//      setTime = training.exercises[activeExercise].setTime
      setPause = training.exercises[activeExercise].setPause
    })
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Training.self, inMemory: true)
}
