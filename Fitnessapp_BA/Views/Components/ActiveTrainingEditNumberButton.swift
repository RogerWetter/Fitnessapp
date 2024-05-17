//
//  CreateExerciseEditNumberRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 13.05.2024.
//

import SwiftUI

struct ActiveTrainingEditNumberButton: View {
  
  @Binding var number: Int?
  @Binding var isEditing: Bool
  var unit: String = ""
  var sysImage: String = ""
  
  @State var isNumberPickerWheelActive = false
  
  var body: some View {
    if number != nil {
      HStack {
        Button {
          isNumberPickerWheelActive.toggle()
        } label: {
          Text(String(number!))
        }
        .tagStyle(isEditing ? TagButtonStyle.bordered : TagButtonStyle.plain)
        .frame(minWidth: 43)
        .popover(isPresented: $isNumberPickerWheelActive, content: {
          NumberPickerWheel(number: Binding(
            get: { number ?? 0 },
            set: { newValue in number = newValue }
          ))
          .presentationCompactAdaptation(.popover)
        })
        if !unit.isEmpty {
          Text(unit)
        }
        if !sysImage.isEmpty {
          Image(systemName: sysImage)
        }
      }
      .fixedSize()
    }
    
  }
}

#Preview {
  HStack {
    ActiveTrainingEditNumberButton(number: .constant(55), isEditing: .constant(false), unit: "kg")
    ActiveTrainingEditNumberButton(number: .constant(55), isEditing: .constant(true), sysImage: "arrow.clockwise")
  }
}
