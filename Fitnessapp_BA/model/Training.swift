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
  var Exercises: [Exercise]?
  
  init(name: String, Exercises: [Exercise]? = nil) {
    self.name = name
    self.Exercises = Exercises
  }
  
  init() {
    self.name = "Trainingseinheit"
    self.Exercises = [Exercise()]
  }
}

@Model
final class Exercise {
  var name: String
  var device: String
  var weight: Int
  var muscleGroup: [MuscleGroup]?
  var repetitions: Int
  var sets: Int
  
  init(name: String, device: String, weight: Int, muscleGroup: [MuscleGroup]? = nil, repetitions: Int = 10, sets: Int = 3) {
    self.name = name
    self.device = device
    self.weight = weight
    self.muscleGroup = muscleGroup
    self.repetitions = repetitions
    self.sets = sets
  }
  
  init() {
    self.name = "NAme"
    self.device = "Gerät"
    self.weight = 50
    self.muscleGroup = [MuscleGroup(name: "Test")]
    self.repetitions = 10
    self.sets = 3
  }
}

@Model
final class MuscleGroup{
  var name: String
  
  init(name: String) {
    self.name = name
  }
}
