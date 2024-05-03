//
//  TrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI

struct TrainingView: View {
  
  @Bindable var training: Training
  
  var body: some View {
    List {
      ForEach(training.Exercises) { exercise in
        NavigationLink {
          //ExerciseView(exercise: exercise)
          
        } label: {
          ExerciseRow(exercise: exercise)
          
        }
      }
      .onDelete(perform: deleteExercise)
      
      Button(action: addExercise) {
        Label("Add Exercise", systemImage: "plus")
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
      ToolbarItem {
        Button(action: addExercise) {
          Label("Add Exercise", systemImage: "plus")
        }
      }
    }
  }
  
  private func addExercise() {
    withAnimation {
      let newExercise = Exercise()
      training.Exercises.append(newExercise)
    }
  }
  
  private func deleteExercise(offsets: IndexSet) {
    withAnimation {
      for index in offsets {
        training.Exercises.remove(at: index)
      }
    }
  }
}


 #Preview {
 TrainingView(training: Training())
     .modelContainer(for: Training.self, inMemory: true)
 }
 
