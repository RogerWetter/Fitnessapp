//
//  TrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI

struct TrainingView: View {
  
  @Bindable var training: Training
  
  
  @State var searchingText = ""
  
  var filteredExercises: [Exercise] {
    guard !searchingText.isEmpty else { return training.Exercises }
    
    return training.Exercises.filter { exercise in
      exercise.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  @State private var isShowingAddExerciseView = false
  @State private var isShowingActiveTrainingView = false
  
  var body: some View {
    List {
      ForEach(filteredExercises) { exercise in
        NavigationLink {
          ActiveTrainingView(training: training)
          
        } label: {
          ExerciseRow(exercise: exercise)
          
        }
      }
      .onDelete(perform: deleteExercise)
      Section {
        Button(action: addExercise) {
          Label("Add Exercise", systemImage: "plus")
        }
      }
    }
    .searchable(text: $searchingText)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
      ToolbarItem {
        Button(action: startTraining) {
          Label("Start Training", systemImage: "play.circle.fill").font(.title).foregroundStyle(.accent)
        }
        .labelStyle(.iconOnly)
      }
    }
    .navigationTitle(training.name)
    .sheet(isPresented: $isShowingAddExerciseView) {
      AddExerciseView(training: training).presentationDetents([.large])
    }
    .fullScreenCover(isPresented: $isShowingActiveTrainingView) {
      ActiveTrainingView(training: training)
    }
  }
  
  private func addExercise() {
    withAnimation {
      isShowingAddExerciseView.toggle()
    }
  }
  
  private func startTraining() {
    isShowingActiveTrainingView.toggle()
  }
  
  private func deleteExercise(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        training.Exercises.remove(at: index)
      }
    }
  }
}


// #Preview {
// TrainingView(training: Training())
//     .modelContainer(for: Training.self, inMemory: true)
// }

