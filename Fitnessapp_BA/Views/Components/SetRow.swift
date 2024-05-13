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
      HStack {
        
        if set.weight != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveWeight.toggle()
            } label: {
              Text(String(set.weight!))
            }
            .tagStyle(isEditing ? TagButtonStyle.bordered : TagButtonStyle.plain)
            .frame(minWidth: 43)
            .popover(isPresented: $isNumberPickerWheelActiveWeight, content: {
              NumberPickerWheel(number: Binding(
                get: { set.weight ?? 0 },
                set: { newValue in set.weight = newValue }
              ))
              .presentationCompactAdaptation(.popover)
            })
            Text("kg")
          }
          .fixedSize()
        }
        if set.repetitions != nil {
          HStack {
            Button {
              isNumberPickerWheelActiveRepetitions.toggle()
            } label: {
              Text(String(set.repetitions!))
            }
            .tagStyle(isEditing ? TagButtonStyle.bordered : TagButtonStyle.plain)
            .frame(minWidth: 43)
            .popover(isPresented: $isNumberPickerWheelActiveRepetitions, content: {
              NumberPickerWheel(number: Binding(
                get: { set.repetitions ?? 0 },
                set: { newValue in set.repetitions = newValue }
              ))
              .presentationCompactAdaptation(.popover)
            })
            Image(systemName: "arrow.clockwise")
          }
          .fixedSize()
        }
      }
      .disabled(!isEditing)
      Spacer()
      if isEditing {
        Button {
          isEditing.toggle()
        } label: {
          Label("Done", systemImage: "checkmark")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      } else {
        Button {
          isEditing.toggle()
        } label: {
          Label("Edit", systemImage: "pencil")
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.circle)
      }
      
    }
  }
}

#Preview {
  SetRow(set: .constant(SavedSet(weight: 35, repetitions: 11, sets: 3, setPause: 2, setTime: 3)))
}
