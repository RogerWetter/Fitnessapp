//
//  Exercise.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData

@Model
final class Exercise {
  var name: String
  var notes: String
  var device: String?
  var weight: Int?
  var muscleGroups: [MuscleGroup] = []
  var repetitions: Int?
  var sets: Int?
  var setPause: Int?
  var setTime: Int?
  
  @Attribute(.externalStorage)
  var image: Data?
  
  var trainings: [Training] = []
  
  init(name: String, notes: String = "", device: String?, weight: Int?, muscleGroup: [MuscleGroup] = [], repetitions: Int?, sets: Int?, setPause: Int?, setTime: Int?, image: Data?) {
    self.name = name
    self.notes = notes
    self.device = device
    self.weight = weight
    self.muscleGroups = muscleGroup
    self.repetitions = repetitions
    self.sets = sets
    self.setPause = setPause
    self.setTime = setTime
    self.image = image
  }
}
