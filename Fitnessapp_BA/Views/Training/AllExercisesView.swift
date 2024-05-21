//
//  AllExercisesView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 06.05.2024.
//

import SwiftUI
import SwiftData

struct AllExercisesView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var exercises: [Exercise]
  @State var searchingText = ""
  
  var filteredExercises: [Exercise] {
    guard !searchingText.isEmpty else { return exercises }
    
    return exercises.filter { exercise in
      let exerciseNameContains = exercise.name.lowercased().contains(searchingText.lowercased())
      let muscleGroupContains = exercise.muscleGroups.contains { muscleGroup in
        muscleGroup.name.lowercased().contains(searchingText.lowercased())
      }
      return exerciseNameContains || muscleGroupContains
    }
  }
  
  @State private var isShowingCreateExerciseView = false
  
  var body: some View {
    List {
      Button(action: createExercise) {
        Label("create Exercise", systemImage: "plus")
      }
      Section {
        ForEach(filteredExercises) { exercise in
          ExerciseRow(exercise: exercise)
        }
        .onDelete(perform: deleteExercise)
      }
    }
    .searchable(text: $searchingText)
    .navigationTitle("All Exercises")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
    }
    .sheet(isPresented: $isShowingCreateExerciseView) {
      CreateExerciseView().presentationDetents([.large])
    }
  }
  
  private func createExercise() {
    isShowingCreateExerciseView.toggle()
  }
  
  private func deleteExercise(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        modelContext.delete(filteredExercises[index])
      }
    }
  }
}

#Preview {
  NavigationView {
    AllExercisesView()
  }
}
