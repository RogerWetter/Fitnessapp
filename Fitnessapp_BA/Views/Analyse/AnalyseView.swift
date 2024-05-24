//
//  AnalyseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI
import SwiftData

struct AnalyseView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \SavedExercise.timeStamp, order: .reverse) private var savedExercises: [SavedExercise]
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
  
  var body: some View {
    if groupedExercises.isEmpty {
      Text("There are no Saved Exercises.")
    }
    List {
      ForEach(groupedExercises.keys.sorted(by: >), id: \.self) { date in
        Section(header: Text(formattedDate(date))) {
          ForEach(groupedExercises[date] ?? []) { savedExercise in
            if let exercise = savedExercise.exercise {
              NavigationLink {
                ExerciseAnalyseView(exercise: exercise)
              } label: {
                ExerciseRowActiveTraining(exercise: savedExercise.exercise!, savedExercise: savedExercise)
              }
            }
          }
          .onDelete { indexSet in
            deleteExercise(at: indexSet, from: date)
          }
        }
      }
    }
    .searchable(text: $searchingText)
    .navigationTitle("Saved Exercises")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        EditButton()
      }
    }
  }
  
  private var groupedExercises: [Date: [SavedExercise]] {
    Dictionary(grouping: filteredExercises) { exercise in
      // Remove time components from the date
      let calendar = Calendar.current
      let components = calendar.dateComponents([.year, .month, .day], from: exercise.timeStamp)
      return calendar.date(from: components) ?? exercise.timeStamp
    }
  }
  
  private func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter.string(from: date)
  }
  
  private func deleteExercise(at offsets: IndexSet, from date: Date) {
    withAnimation {
      for index in offsets {
        if let exercise = groupedExercises[date]?[index] {
          modelContext.delete(exercise)
        }
      }
    }
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
  let preview = Preview()
  preview.addExamples(SavedExercise.sampleSavedExercises)
  return ContentView()
    .modelContainer(preview.container)
}
