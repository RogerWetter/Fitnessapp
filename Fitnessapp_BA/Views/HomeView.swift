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
  @State private var isShowingActiveTrainingView = false
  @State private var isShowingSettingsView = false
  @State private var isShowingAddTrainingView = false
  
  
  @State var searchingText = ""
  
  var filteredExercises: [Training] {
    guard !searchingText.isEmpty else { return trainings }
    
    return trainings.filter { training in
      training.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  var body: some View {
    NavigationSplitView {
      HStack {
        Text("Trainings")
          .font(.headline)
        Spacer()
        NavigationLink {
          AllExercisesView()
        } label: {
          Label("All Exercises", systemImage: "figure.strengthtraining.traditional")
            .labelStyle(.titleOnly)
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
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
      .searchable(text: $searchingText)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: openSettings) {
            Label("open Settings", systemImage: "gearshape").foregroundStyle(.gray)
          }
        }
      }
        .navigationTitle("Home")
    } detail: {
      Text("Select a Training")
    }
    .sheet(isPresented: $isShowingAddTrainingView) {
      AddTrainingView().presentationDetents([.fraction(0.20)])
    }
    .fullScreenCover(isPresented: $isShowingActiveTrainingView) {
      ActiveTrainingView(training: trainings[0])// richtiges Training muss noch mitgegeben werden!
    }
    .fullScreenCover(isPresented: $isShowingSettingsView) {
      SettingsView()
    }
  }
  
  private func addTraining() {
    withAnimation {
      isShowingAddTrainingView.toggle()
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
    isShowingActiveTrainingView.toggle()
  }
  
  private func openSettings() {
    withAnimation {
      isShowingSettingsView.toggle()
    }
  }
}

#Preview {
  HomeView()
    .modelContainer(for: Training.self, inMemory: true)
}
