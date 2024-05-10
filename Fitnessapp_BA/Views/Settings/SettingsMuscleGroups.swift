//
//  SettingsMuscleGroups.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 08.05.2024.
//

import SwiftUI
import SwiftData

struct SettingsMuscleGroups: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var muscleGroups: [MuscleGroup]
  
  @State var searchingText = ""
  var filteredMuscleGroups: [MuscleGroup] {
    guard !searchingText.isEmpty else { return muscleGroups }
    
    return muscleGroups.filter { muscleGroup in
      muscleGroup.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  var body: some View {
      List {
        ForEach(filteredMuscleGroups) { muscleGroup in
          Text(muscleGroup.name)
            .padding(/*@START_MENU_TOKEN@*/.all, 1.0/*@END_MENU_TOKEN@*/)
            .background(muscleGroup.getColor())
            .cornerRadius(5.0)
        }
        .onDelete(perform: deleteMuscleGroup)
      }
      .searchable(text: $searchingText)
      .navigationTitle("Muscle Groups")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
      }
  }
  
  private func deleteMuscleGroup(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(filteredMuscleGroups[index])
      }
    }
  }
}

#Preview {
  SettingsMuscleGroups()
}
