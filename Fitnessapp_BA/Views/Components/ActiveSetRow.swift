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
  @Binding var weight: Int
  @Binding var repetitions: Int
  
  @State var isEditing = false
  @State var isNumberPickerWheelActiveWeight = false
  @State var isNumberPickerWheelActiveRepetitions = false
  
    var body: some View {
      
      HStack {
        if training.Exercises[activeExercise].weight != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveWeight.toggle()
            } label: {
              Text(String(weight))
            }
            .frame(minWidth: 43)
            .buttonStyle(.bordered)
            Text("kg")
          }
          .fixedSize()
          .onAppear(perform: {
            weight = training.Exercises[activeExercise].weight!
          })
        }
        if training.Exercises[activeExercise].repetitions != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveRepetitions.toggle()
            } label: {
              Text(String(repetitions))
            }
            .frame(minWidth: 43)
            .buttonStyle(.bordered)
            Image(systemName: "arrow.clockwise")
          }
          .fixedSize()
          .onAppear(perform: {
            repetitions = training.Exercises[activeExercise].repetitions!
          })
        }
      }
      .popover(isPresented: $isNumberPickerWheelActiveWeight, content: {
        NumberPickerWheel(number: $weight)
          .presentationCompactAdaptation(.popover)
      })
      .popover(isPresented: $isNumberPickerWheelActiveRepetitions, content: {
        NumberPickerWheel(number: $repetitions)
          .presentationCompactAdaptation(.popover)
      })
    }
}

#Preview {
  ContentView()
    .modelContainer(for: Training.self, inMemory: true)
}
