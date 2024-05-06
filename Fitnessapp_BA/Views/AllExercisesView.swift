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
      exercise.name.lowercased().contains(searchingText.lowercased())
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
      }
    }
    .searchable(text: $searchingText)
    .navigationTitle("All Exercises")
    .toolbar {
      
    }
    .sheet(isPresented: $isShowingCreateExerciseView) {
      CreateExerciseView().presentationDetents([.large])
    }
  }
  
  private func createExercise() {
    isShowingCreateExerciseView.toggle()
  }
}

#Preview {
  AllExercisesView()
}
