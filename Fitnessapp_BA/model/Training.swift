//
//  Training.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Training {
  var name: String
  @Relationship(inverse: \Exercise.trainings)
  var exercisesUnsorted: [Exercise] = []
  
  private var exercisesOrder: [PersistentIdentifier] = []
  
  var exercises: [Exercise] {
    updateLists()
    if exercisesUnsorted.isEmpty {
      return []
    }
    return exercisesOrder.compactMap { id in
      exercisesUnsorted.first { $0.id == id }
    }
  }
  
  var uniqueMuscleGroups: [MuscleGroup] {
    var uniqueMuscleGroups = Set<MuscleGroup>()
    for exercise in self.exercisesUnsorted {
      uniqueMuscleGroups.formUnion(exercise.muscleGroups)
    }
    return Array(uniqueMuscleGroups)
  }
  
  init(name: String) {
    self.name = name
  }
  
  init() {
    self.name = "Trainingseinheit"
  }
  
  func addExercise(_ exercise: Exercise) {
    exercisesUnsorted.append(exercise)
    exercisesOrder.append(exercise.id)
  }
  
  func addExercises(_ exercisesToAdd: [Exercise]) {
    for exercise in exercisesToAdd {
      exercisesUnsorted.append(exercise)
      exercisesOrder.append(exercise.id)
    }
  }
  
  func removeExercise(at index: Int) {
    exercisesUnsorted.removeAll(where: {$0.id == exercisesOrder[index]})
    exercisesOrder.remove(at: index)
  }
  
  func removeExercise(exercise: Exercise) {
    exercisesUnsorted.removeAll(where: {$0.id == exercise.id})
    exercisesOrder.removeAll(where: {$0 == exercise.id})
  }
  
  func getEditableExercise(at index: Int) -> Binding<Exercise> {
    guard index < exercisesOrder.count else {
      fatalError("Index out of bounds")
    }
    let exerciseID = exercisesOrder[index]
    guard let exerciseIndex = exercisesUnsorted.firstIndex(where: { $0.id == exerciseID }) else {
      fatalError("Exercise not found")
    }
    return Binding(
      get: { self.exercisesUnsorted[exerciseIndex] },
      set: { self.exercisesUnsorted[exerciseIndex] = $0 }
    )
  }
  
  
  func moveExercise(from sourceIndex: Int, to destinationIndex: Int) {
    guard sourceIndex != destinationIndex else { return }
    let movedOrder = exercisesOrder.remove(at: sourceIndex)
    exercisesOrder.insert(movedOrder, at: (sourceIndex < destinationIndex) ? (destinationIndex - 1) : destinationIndex)
  }
  
  func updateLists() {
    if exercisesOrder.count != exercisesUnsorted.count {
      exercisesOrder.removeAll(where: {exerciseOrder in !exercisesUnsorted.contains(where: {$0.id == exerciseOrder})})
    }
  }
  
}


