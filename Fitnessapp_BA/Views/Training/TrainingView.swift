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
    guard !searchingText.isEmpty else { return training.exercises }
    
    return training.exercises.filter { exercise in
      exercise.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  @State private var isShowingAddExerciseView = false
  @State private var isShowingActiveTrainingView = false
  
  var body: some View {
    List {
      ForEach(filteredExercises) { exercise in
        NavigationLink(destination: {
          ExerciseView(exercise: .constant(exercise))
        }, label: {
          ExerciseRow(exercise: exercise)})
      }
      .onMove { indices, newOffset in
//        training.moveExercise(from: from, to: to) // Cannot convert value of type 'IndexSet' to expected argument type 'Int'
        if let oldOffset = indices.first {
            training.moveExercise(from: oldOffset, to: newOffset)
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
  
  private func openOptionsForExerciseEdit() {
    withAnimation {
      isShowingAddExerciseView.toggle()
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
//        training.exercises.remove(at: index)
        training.removeExercise(at: index)
      }
    }
  }
}


// #Preview {
// TrainingView(training: Training())
//     .modelContainer(for: Training.self, inMemory: true)
// }

