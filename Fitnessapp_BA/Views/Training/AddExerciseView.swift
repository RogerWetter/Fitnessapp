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
  
  var filteredExercises: [Exercise] {
    guard !searchingText.isEmpty else { return exercises }
    
    return exercises.filter { exercise in
      exercise.name.lowercased().contains(searchingText.lowercased())
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
            ForEach(filteredExercises) { exercise in
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
                  Image(systemName: exercisesToAdd.contains(exercise) ? "checkmark.circle" : "plus.circle")
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
          CreateExerciseView().presentationDetents([.large])
        }
    }
  }
  
  private func dismissAction() {
    dismiss()
  }
  
  private func doneAction() {
    training.Exercises.append(contentsOf: exercisesToAdd)
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
