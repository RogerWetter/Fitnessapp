//
//  SetRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct SetRow: View {
  
  @Binding var set: SavedSet
  @Binding var sets: [SavedSet]
  
  @State var isEditing = false
  @State var isNumberPickerWheelActiveWeight = false
  @State var isNumberPickerWheelActiveRepetitions = false
//  let columns = [GridItem(.flexible()), GridItem(.flexible())]
  let columns = [GridItem(.adaptive(minimum: 44))]
  
  var body: some View {
    HStack {
      
      HStack {
        ActiveTrainingEditNumberButton(number: $set.weight, isEditing: $isEditing, unit: "kg")
        ActiveTrainingEditNumberButton(number: $set.repetitions, isEditing: $isEditing, sysImage: "arrow.clockwise")
//        ActiveTrainingEditNumberButton(number: $set.setTime, isEditing: $isEditing, sysImage: "clock.arrow.2.circlepath")
        ActiveTrainingEditNumberButton(number: $set.setPause, isEditing: $isEditing, sysImage: "pause")
      }
      .disabled(!isEditing)
      Spacer()
      if isEditing {
        
        Button(role: .destructive) {
          sets.removeAll(where: {$0 == set})
        } label: {
          Label("Delete", systemImage: "trash")
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        
        Button {
          sets.append(SavedSet(weight: set.weight, repetitions: set.repetitions, setPause: set.setPause, setTime: set.setTime))
          isEditing.toggle()
        } label: {
          Label("Duplicate", systemImage: "rectangle.on.rectangle")
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        
        Button {
          isEditing.toggle()
        } label: {
          Label("Done", systemImage: "checkmark")
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        
      } else {
        Button {
          isEditing.toggle()
        } label: {
          Label("Edit", systemImage: "pencil")
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
      }
      
    }
  }
}

#Preview {
  VStack {
    SetRow(set: .constant(SavedSet(weight: 35, repetitions: 11, setPause: 2, setTime: 3)), sets: .constant([]))
    SetRow(set: .constant(SavedSet(weight: 5, repetitions: 9)), sets: .constant([]))
    SetRow(set: .constant(SavedSet(weight: 77, repetitions: 10, setTime: 3)), sets: .constant([]))
  }
}
