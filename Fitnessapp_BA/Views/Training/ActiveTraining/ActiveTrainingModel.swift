//
//  ActiveTrainingModel.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 19.05.2024.
//

import Foundation
import SwiftUI
import SwiftData

class ActiveTrainingModel: ObservableObject, Identifiable {
  let modelContext: ModelContext
  
  
  @Bindable var training: Training
  
  private var activeExerciseIdx: Int = 0
  
  var exercise: Exercise {
    return training.exercises[activeExerciseIdx]
  }
  
  var editableExercise: Binding<Exercise> {
    return training.getEditableExercise(at: activeExerciseIdx)
  }
  
  var exerciseNumber: Int {
    return activeExerciseIdx + 1
  }
  
  @Published var isSetActive = false
  @Published var isShowingList = false
  
  @Published var savedExercises: [SavedExercise] = []
  @Published var sets: [SavedSet] = []
  
  init(modelContext: ModelContext, training: Training) {
    self.modelContext = modelContext
    self.training = training
  }
  
  func saveExercises() {
    saveSets()
    for savedExercise in savedExercises {
      modelContext.insert(savedExercise)
    }
  }
  
  func saveSets() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == exercise }) {
      savedExercises[existingSavedExerciseIndex].sets = sets
    } else {
      // I am afraid, this has to be like this
//      let exercise = exercise
      let savedExercise = SavedExercise(exercise: nil, sets: sets)
      modelContext.insert(exercise)
      savedExercise.exercise = exercise
      savedExercises.append(savedExercise)
    }
  }
  
  func loadSets() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == exercise }) {
      sets = savedExercises[existingSavedExerciseIndex].sets
    } else {
      sets = []
    }
  }
  
  func startSet() {
    isSetActive.toggle()
  }
  
  func endSet() {
    sets.append(SavedSet(weight: exercise.weight, repetitions: exercise.repetitions, setPause: exercise.setPause, setTime: exercise.setTime))
    isSetActive.toggle()
    saveSets()
  }
  
  
  private func backward() {
    saveSets()
    if activeExerciseIdx > 0 {
      activeExerciseIdx -= 1
    }
    loadSets()
  }
  
  func forward() {
    saveSets()
    nextExercise()
    loadSets()
  }
  
  func changeExercise(to index: Int) {
    guard index >= 0 && index < training.exercises.count else {
      return
    }
    saveSets()
    activeExerciseIdx = index
    loadSets()
    isShowingList.toggle()
  }
  
  private func nextExercise() {
    if activeExerciseIdx + 1 < training.exercises.count {
      activeExerciseIdx += 1
    }
  }
}
