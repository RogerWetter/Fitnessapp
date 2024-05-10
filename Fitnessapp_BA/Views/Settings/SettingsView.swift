//
//  SettingsView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct SettingsView: View {
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationStack {
        List {
          Section(header: Text("My Data")) {
            NavigationLink {
              SettingsTrainings()
            } label: {
              Text("Trainings")
            }
            NavigationLink {
              SettingsExercises()
            } label: {
              Text("Exercises")
            }
            NavigationLink {
              SettingsMuscleGroups()
            } label: {
              Text("Muscle Groups")
            }
          }
          Section(header: Text("My History")) {
            NavigationLink {
              SettingsSavedExercises()
            } label: {
              Text("Saved Exercises")
            }
          }
        }
        .navigationTitle("Settings")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: dismissAction) {
              Text("Done")
                .fontWeight(.semibold)
            }
          }
        }
    }
  }
  
  private func dismissAction() {
    dismiss()
  }
}

#Preview {
  SettingsView()
}
