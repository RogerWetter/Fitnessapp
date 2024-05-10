//
//  Exercise.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData

@Model
final class SavedSet {
  var weight: Int?
  var repetitions: Int?
  var sets: Int?
  var setPause: Int?
  var setTime: Int?
  
  init(weight: Int? = nil, repetitions: Int? = nil, sets: Int? = nil, setPause: Int? = nil, setTime: Int? = nil) {
    self.weight = weight
    self.repetitions = repetitions
    self.sets = sets
    self.setPause = setPause
    self.setTime = setTime
  }
}
