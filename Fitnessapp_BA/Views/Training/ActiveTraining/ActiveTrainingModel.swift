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
  
  @Published var activeExercise: Int = 0
  
  @Published var weight: Int?
  @Published var repetitions: Int?
  //  @Published var setTime: Int?
  @Published var setPause: Int?
  
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
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == training.exercises[activeExercise] }) {
      savedExercises[existingSavedExerciseIndex].sets = sets
    } else {
      // I am afraid, this has to be like this
      let exercise = training.exercises[activeExercise]
      let savedExercise = SavedExercise(exercise: nil, sets: sets)
      modelContext.insert(exercise)
      savedExercise.exercise = exercise
      savedExercises.append(savedExercise)
    }
  }
  
  func loadSets() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == training.exercises[activeExercise] }) {
      sets = savedExercises[existingSavedExerciseIndex].sets
    } else {
      sets = []
    }
  }
  
  func startSet() {
    isSetActive.toggle()
  }
  
  func endSet(set: SavedSet) {
    sets.append(set)
    isSetActive.toggle()
  }
  
  
  private func backward() {
    saveSets()
    if activeExercise > 0 {
      activeExercise -= 1
    }
    loadSets()
  }
  
  func forward() {
    saveSets()
    nextExercise()
    loadSets()
    weight = training.exercises[activeExercise].weight
    repetitions = training.exercises[activeExercise].repetitions
    //    setTime = training.exercises[activeExercise].setTime
    setPause = training.exercises[activeExercise].setPause
  }
  
  private func nextExercise() {
    if activeExercise + 1 < training.exercises.count {
      activeExercise += 1
    }
  }
}
