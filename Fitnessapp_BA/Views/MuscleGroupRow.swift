//
//  MuscleGroupRow.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct MuscleGroupRow: View {
  
  let muscleGroups: [MuscleGroup]
  
  var body: some View {
    HStack {
      ForEach(muscleGroups) { muscleGroup in
        Text(muscleGroup.name)
          .padding(/*@START_MENU_TOKEN@*/.all, 1.0/*@END_MENU_TOKEN@*/)
          .background(muscleGroup.getColor())
          .cornerRadius(5.0)
      }
      
    }
  }
}

#Preview {
  MuscleGroupRow(muscleGroups: [MuscleGroup(name: "OberKörper", color: MuscleGroupColor.green.rawValue), MuscleGroup(name: "Beine", color: MuscleGroupColor.orange.rawValue), MuscleGroup(name: "Rumpf", color: MuscleGroupColor.purple.rawValue)])
}
