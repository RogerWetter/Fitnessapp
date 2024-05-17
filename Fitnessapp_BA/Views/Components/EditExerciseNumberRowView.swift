//
//  EditExerciseNumberRowView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 16.05.2024.
//

import SwiftUI

struct EditExerciseNumberRowView: View {
  @Binding var number: Int
  let sysImage: String
  let name: String
  let unit: String
  
  var body: some View {
    HStack {
      Image(systemName: sysImage)
        .frame(width: 40)
      Text("\(name):")
      Spacer()
      EditNumberButton(number: $number)
      Text(unit)
        .multilineTextAlignment(.leading)
        .frame(minWidth: 40, alignment: .leading)
    }
    
  }
  
}

#Preview {
  VStack {
    EditExerciseNumberRowView(number: .constant(55), sysImage: "scalemass", name: "Weight", unit: "kg")

    EditExerciseNumberRowView(number: .constant(10), sysImage: "arrow.clockwise", name: "Repetitions", unit: "x")

    EditExerciseNumberRowView(number: .constant(3), sysImage: "arrow.triangle.2.circlepath", name: "Sets", unit: "x")

    EditExerciseNumberRowView(number: .constant(5), sysImage: "clock.arrow.2.circlepath", name: "Set Time", unit: "min")

    EditExerciseNumberRowView(number: .constant(2), sysImage: "pause", name: "Set Pause", unit: "min")
  }
}
