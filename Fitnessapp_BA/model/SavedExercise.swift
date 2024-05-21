//
//  Exercise.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData

@Model
final class SavedExercise {
  var timeStamp: Date
  var exercise: Exercise?
  var sets: [SavedSet]

  init(exercise: Exercise?, sets: [SavedSet]) {
    self.timeStamp = Date()
    self.exercise = exercise
    self.sets = sets
  }
  
  init(timeStamp: Date, exercise: Exercise?, sets: [SavedSet]) {
    self.timeStamp = timeStamp
    self.exercise = exercise
    self.sets = sets
  }
}

