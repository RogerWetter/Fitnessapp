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
  @State private var isShowingSettingsView = false
  @State private var isShowingAddTrainingView = false
  @State private var selectedTraining: Training?
  
  
  @State var searchingText = ""
  
  var filteredTrainings: [Training] {
    guard !searchingText.isEmpty else { return trainings }
    
    return trainings.filter { training in
      training.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  var body: some View {
    List {
      Section(header:
                HStack {
        Text("Trainings")
        Spacer()
        NavigationLink {
          AllExercisesView()
        } label: {
          Label("All Exercises", systemImage: "figure.strengthtraining.traditional")
            .labelStyle(.titleOnly)
        }
      }) {
        ForEach(filteredTrainings) { training in
          HStack {
            TrainingRow(training: training)
              .background(
                NavigationLink("", destination: TrainingView(training: training))
                  .opacity(0)
              )
            if training.Exercises.count > 0 {
              Button {
                selectedTraining = training
              } label: {
                Label{
                  Text("Start Training")
                } icon: {
                  Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, .accent)
                }
              }
              .labelStyle(.iconOnly)
            }
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
    .sheet(isPresented: $isShowingAddTrainingView) {
      AddTrainingView().presentationDetents([.fraction(0.20)])
    }
    .fullScreenCover(item: $selectedTraining) { training in
      ActiveTrainingView(training: training)
    }
    .sheet(isPresented: $isShowingSettingsView) {
      SettingsView().presentationDetents([.large])
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
        modelContext.delete(filteredTrainings[index])
      }
    }
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
