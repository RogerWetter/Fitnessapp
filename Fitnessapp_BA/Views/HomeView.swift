//
//  HomeView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 01.05.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var trainings: [Training]
  @State private var isShowingExerciseView = false
  @State private var isShowingaddTrainingView = false
  
  var body: some View {
    NavigationSplitView {
      List {
        Section {
          ForEach(trainings) { training in
            HStack {
              NavigationLink {
                TrainingView(training: training)
              } label: {
                TrainingRow(training: training)
              }
              Button(action: startTraining) {
                Label("Start Training", systemImage: "play.circle.fill").font(.title).foregroundStyle(.accent)
              }
              .labelStyle(.iconOnly)
            }
            .buttonStyle(.plain)
          }
          .onDelete(perform: deleteTraining)
        }
        
        Button(action: addTraining) {
          Label("Add Training", systemImage: "plus")
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          EditButton()
        }
        ToolbarItem {
          Button(action: addTraining) {
            Label("Add Training", systemImage: "plus")
          }
        }
      }
    } detail: {
      Text("Select a Training")
    }
    .sheet(isPresented: $isShowingaddTrainingView) {
      addTrainingView()
    }
  }
  
  private func addTraining() {
    withAnimation {
      isShowingaddTrainingView.toggle()
    }
  }
  
  private func deleteTraining(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(trainings[index])
      }
    }
  }
  
  private func startTraining() {
    //isShowingExerciseView = true
  }
}

#Preview {
  HomeView()
    .modelContainer(for: Training.self, inMemory: true)
}
