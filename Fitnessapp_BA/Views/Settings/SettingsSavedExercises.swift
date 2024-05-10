//
//  SettingsMuscleGroups.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 08.05.2024.
//

import SwiftUI
import SwiftData

struct SettingsSavedExercises: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var savedExercises: [SavedExercise]
  @State var searchingText = ""
  
  var filteredExercises: [SavedExercise] {
    guard !searchingText.isEmpty else { return savedExercises }
    
    return savedExercises.filter { savedExercise in
      let exerciseNameContains = savedExercise.exercise?.name.lowercased().contains(searchingText.lowercased()) ?? false
      let muscleGroupContains = savedExercise.exercise?.muscleGroups.contains { muscleGroup in
        muscleGroup.name.lowercased().contains(searchingText.lowercased())
      } ?? false
      return exerciseNameContains || muscleGroupContains
    }
  }
  
  @State private var isShowingCreateExerciseView = false
  
  var body: some View {
    List {
      Section {
        ForEach(filteredExercises) { savedExercise in
          VStack {
            Text(savedExercise.timeStamp.ISO8601Format())
            if savedExercise.exercise != nil {
              ExerciseRow(exercise: savedExercise.exercise!)
            }
//            ForEach(savedExercise.sets) { savedSet in
//              Text("weight: \(String(savedSet.weight)) repetitions \(String(savedSet.repetitions))")
//            }
          }
        }
        .onDelete(perform: deleteExercise)
      }
    }
    .searchable(text: $searchingText)
    .navigationTitle("Saved Exercises")
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
  SettingsExercises()
}
