//
//  SettingsMuscleGroups.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 08.05.2024.
//

import SwiftUI
import SwiftData

struct SettingsTrainings: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var trainings: [Training]
  
  @State var searchingText = ""
  var filteredTrainings: [Training] {
    guard !searchingText.isEmpty else { return trainings }
    
    return trainings.filter { training in
      training.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  var body: some View {
      List {
        ForEach(filteredTrainings) { training in
          Text(training.name)
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
        modelContext.delete(filteredTrainings[index])
      }
    }
  }
}

#Preview {
  SettingsMuscleGroups()
}
