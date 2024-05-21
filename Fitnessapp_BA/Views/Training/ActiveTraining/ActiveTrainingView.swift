//
//  ActiveTrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct ActiveTrainingView: View {
  
  @StateObject var activeTrainingModel: ActiveTrainingModel
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      if activeTrainingModel.training.exercises.isEmpty {
        VStack {
          Text("This Training has no Exercises Yet.")
          Button {
            dismiss()
          } label: {
            Text("Go Back")
          }
        }
      } else {
        VStack {
          if activeTrainingModel.isShowingList {
            ActiveTrainingListView(dismiss: dismiss).environmentObject(activeTrainingModel)
          } else {
            ActiveTrainingExerciseView(dismiss: dismiss).environmentObject(activeTrainingModel)
          }
        }
        .navigationTitle(activeTrainingModel.training.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem {
            Button {
              activeTrainingModel.saveExercises()
              dismiss()
            } label: {
              Text("End")
                .fontWeight(.semibold)
            }
          }
        }
      }
    }
  }
}

//#Preview {
//  ActiveTrainingView(training: Training(name: "Test"))
//    .modelContainer(for: Training.self, inMemory: true)
//}
