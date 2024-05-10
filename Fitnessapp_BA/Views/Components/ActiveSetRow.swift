//
//  SetRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct SetRow: View {
  
  @Binding var set: SavedSet
  
  @State var isEditing = false
  @State var isNumberPickerWheelActiveWeight = false
  @State var isNumberPickerWheelActiveRepetitions = false
  
    var body: some View {
      
      HStack {
        if set.weight != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveWeight.toggle()
            } label: {
              Text(String(set.weight!))
            }
            .disabled(isEditing)
            .buttonStyle(.bordered)
            Text("kg")
          }
        }
        if set.repetitions != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveRepetitions.toggle()
            } label: {
              Text(String(set.repetitions!))
            }
            .disabled(isEditing)
            .buttonStyle(.bordered)
            Image(systemName: "arrow.clockwise")
          }
        }
        Spacer()
        Button {
          isEditing.toggle()
        } label: {
          Label("Edit", systemImage: "pencil")
        }
      }
      .popover(isPresented: $isNumberPickerWheelActiveWeight, content: {
        NumberPickerWheel(number: Binding(
                get: { set.weight ?? 0 },
                set: { newValue in set.weight = newValue }
              )).presentationDetents([.medium])
      })
      .popover(isPresented: $isNumberPickerWheelActiveRepetitions, content: {
        NumberPickerWheel(number: Binding(
                get: { set.repetitions ?? 0 },
                set: { newValue in set.repetitions = newValue }
              )).presentationDetents([.medium])
      })
    }
}

#Preview {
  SetRow(set: .constant(SavedSet(weight: 35, repetitions: 11, sets: 3, setPause: 2, setTime: 3)))
}
