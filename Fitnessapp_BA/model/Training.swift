//
//  Item.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData

@Model
final class Training {
  var name: String
  var Exercises: [Exercise] = []
  var uniqueMuscleGroups: [MuscleGroup] {
      var uniqueMuscleGroups = Set<MuscleGroup>()
      for exercise in self.Exercises {
          uniqueMuscleGroups.formUnion(exercise.muscleGroups)
      }
      return Array(uniqueMuscleGroups)
  }
  
  init(name: String) {
    self.name = name
  }
  
  init() {
    self.name = "Trainingseinheit"
    self.Exercises = [Exercise()]
  }
}
