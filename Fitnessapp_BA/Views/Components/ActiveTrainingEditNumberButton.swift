//
//  CreateExerciseEditNumberRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 13.05.2024.
//

import SwiftUI

struct EditNumberButton: View {
  @State var isNumberPickerWheelActive = false
  @Binding var number: Int
  
  var body: some View {
    Button {
      isNumberPickerWheelActive.toggle()
    } label: {
      Text(String(number))
        .frame(minWidth: 43)
    }
    .tagStyle(TagButtonStyle.bordered)
    .popover(isPresented: $isNumberPickerWheelActive, content: {
      NumberPickerWheel(number: $number)
        .presentationCompactAdaptation(.popover)
    })
    
  }
}

#Preview {
  EditNumberButton(number: .constant(55))
}
