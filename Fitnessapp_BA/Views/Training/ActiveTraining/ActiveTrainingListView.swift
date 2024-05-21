//
//  ActiveTrainingListView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 19.05.2024.
//

import SwiftUI

struct ActiveTrainingListView: View {
  
  @EnvironmentObject var activeTrainingModel: ActiveTrainingModel
  var dismiss: DismissAction
  
  var body: some View {
    List {
      ForEach(activeTrainingModel.training.exercises.indices, id: \.self) { idx in
        HStack {
          Button {
            activeTrainingModel.saveSets()
            activeTrainingModel.activeExercise = idx
            activeTrainingModel.loadSets()
            activeTrainingModel.isShowingList.toggle()
          } label: {
            ExerciseRowActiveTraining(exercise: activeTrainingModel.training.exercises[idx], savedExercise: activeTrainingModel.savedExercises.first(where: { $0.exercise == activeTrainingModel.training.exercises[idx] }))
          }
          .buttonStyle(.plain)
        }
      }
      .onMove { indices, newOffset in
        if let oldOffset = indices.first {
          activeTrainingModel.training.moveExercise(from: oldOffset, to: newOffset)
        }
      }
    }
    HStack {
      Button {
        activeTrainingModel.isShowingList.toggle()
      } label: {
        Label("Open List", systemImage: "list.bullet")
          .labelStyle(.iconOnly)
      }
      .padding()
      Button {
        // Scan QR
      } label: {
        Label("Scan QR-Code", systemImage: "qrcode.viewfinder")
          .labelStyle(.iconOnly)
      }
      .padding()
      Button {
        activeTrainingModel.saveExercises()
        dismiss()
      } label: {
        Text("End Training")
          .frame(maxWidth: .infinity)
          .font(.title2)
      }
      .buttonStyle(.bordered)
    }
    .padding(.horizontal)
  }
}

//#Preview {
//  ActiveTrainingListView()
//}
