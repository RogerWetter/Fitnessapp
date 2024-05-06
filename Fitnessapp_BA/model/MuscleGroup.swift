//
//  MuscleGroup.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import Foundation
import SwiftData
import SwiftUI


@Model
final class MuscleGroup {
  var name: String
  var color: String
  
  init(name: String, color: String) {
    self.name = name
    self.color = color
  }
  
  func getColor() -> Color {
    switch color {
    case MuscleGroupColor.red.rawValue:
      return .red
    case MuscleGroupColor.green.rawValue:
      return .green
    case MuscleGroupColor.blue.rawValue:
      return .blue
    case MuscleGroupColor.orange.rawValue:
      return .orange
    case MuscleGroupColor.yellow.rawValue:
      return .yellow
    case MuscleGroupColor.mint.rawValue:
      return .mint
    case MuscleGroupColor.teal.rawValue:
      return .teal
    case MuscleGroupColor.cyan.rawValue:
      return .cyan
    case MuscleGroupColor.indigo.rawValue:
      return .indigo
    case MuscleGroupColor.purple.rawValue:
      return .purple
    case MuscleGroupColor.pink.rawValue:
      return .pink
    case MuscleGroupColor.brown.rawValue:
      return .brown
    default:
      return .gray
    }
  }
}

enum MuscleGroupColor: String {
  case red = "red"
  case green = "green"
  case blue = "blue"
  case orange = "orange"
  case yellow = "yellow"
  case mint = "mint"
  case teal = "teal"
  case cyan = "cyan"
  case indigo = "indigo"
  case purple = "purple"
  case pink = "pink"
  case brown = "brown"
}
