//
//  addExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI
import SwiftData

struct AddExerciseView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query private var exercises: [Exercise]
  @State var searchingText = ""
  
  var filteredExercisesNotInTraining: [Exercise] {
    return exercises.filter { exercise in
      !training.exercises.contains(exercise)
    }
  }
  
  var filteredExercisesSearchbar: [Exercise] {
    guard !searchingText.isEmpty else { return filteredExercisesNotInTraining }
    
    return filteredExercisesNotInTraining.filter { exercise in
      exercise.name.lowercased().contains(searchingText.lowercased())
    }
  }
  
  var filteredExercisesNotMarked: [Exercise] {
    return filteredExercisesSearchbar.filter { exercise in
      !filteredExercisesMarked.contains(exercise)
    }
  }
  
  var filteredExercisesMarked: [Exercise] {
    return filteredExercisesSearchbar.filter { exercise in
      exercisesToAdd.contains(exercise) || training.exercises.contains(exercise)
    }
  }
  
  @Bindable var training: Training
  
  @State private var exercisesToAdd: [Exercise] = []
  
  @State private var isShowingCreateExerciseView = false
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      VStack {
        List {
          Button(action: createExercise) {
            Label("create Exercise", systemImage: "plus")
          }
          Section {
            ForEach(filteredExercisesMarked) { exercise in
              HStack() {
                ExerciseRow(exercise: exercise)
                Spacer()
                Button {
                  if exercisesToAdd.contains(exercise) {
                    exercisesToAdd.removeAll(where: {
                      $0 == exercise
                    })
                  } else {
                    exercisesToAdd.append(exercise)
                  }
                } label: {
                  Image(systemName: "checkmark.circle")
                    .imageScale(.large)
                }
              }
            }
          }
          Section {
            ForEach(filteredExercisesNotMarked) { exercise in
              HStack() {
                ExerciseRow(exercise: exercise)
                Spacer()
                Button {
                  if exercisesToAdd.contains(exercise) {
                    exercisesToAdd.removeAll(where: {
                      $0 == exercise
                    })
                  } else {
                    exercisesToAdd.append(exercise)
                  }
                } label: {
                  Image(systemName: "plus.circle")
                    .imageScale(.large)
                }
              }
            }
          }
        }
        .searchable(text: $searchingText)
      }
        .navigationTitle("Add to \(training.name)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button(action: dismissAction) {
              Text("Cancel")
            }
            .foregroundColor(.red)
          }
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: doneAction) {
              Text("Done")
                .fontWeight(.semibold)
            }
          }
        }
        .sheet(isPresented: $isShowingCreateExerciseView) {
          CreateExerciseView(exercisesToAdd: $exercisesToAdd).presentationDetents([.large])
        }
    }
  }
  
  private func dismissAction() {
    dismiss()
  }
  
  private func doneAction() {
//    training.exercises.append(contentsOf: exercisesToAdd)
    training.addExercises(exercisesToAdd)
    dismiss()
  }
  
  private func createExercise() {
    isShowingCreateExerciseView.toggle()
  }
}

#Preview {
    AddExerciseView(training: Training())
    .modelContainer(for: Training.self, inMemory: true)
}
