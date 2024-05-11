//
//  ColorPickerView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 11.05.2024.
//

import SwiftUI

struct ColorPickerView: View {
  @Environment(\.dismiss) var dismiss
  
  @Binding var selection: MuscleGroupColor
  
  let muscleGroupColors: [MuscleGroupColor] = MuscleGroupColor.allCases
  let columns = [GridItem(.adaptive(minimum: 44))]
  
  var body: some View {
    VStack {
      Text("Select a Color")
        .font(.title3)
        .padding(.horizontal)
      Divider()
      
//      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(muscleGroupColors, id: \.self) { muscleGroupColor in
            ZStack {
              //                muscleGroupColor == selection ? Color.accentColor : Color.clear
              Button {
                selection = muscleGroupColor
                dismiss()
              } label: {
                Image(systemName: "square.fill")
                  .foregroundColor(muscleGroupColor.getColor())
              }
              .tagStyle(TagButtonStyle.prominent)
//              .tagStyle(muscleGroupColor == selection ? TagButtonStyle.prominent : TagButtonStyle.bordered)
              .tint(muscleGroupColor == selection ? Color(.systemGray5) : Color(.clear))
            }
          }
        }
//      }
    }
    .padding(.vertical)
  }
}

#Preview {
  ColorPickerView(selection: .constant(MuscleGroupColor.blue))
}
