//
//  TagButtonStyle.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import Foundation
import SwiftUI



enum TagButtonStyle {
  case prominent
  case bordered
  case plain
}

extension Button {
  
  @ViewBuilder
  func tagStyle(_ style: TagButtonStyle) -> some View {
    switch style {
    case .prominent:
      self.buttonStyle(BorderedProminentButtonStyle())
    case .bordered:
      self.buttonStyle(BorderedButtonStyle())
    case .plain:
      self.buttonStyle(PlainButtonStyle())
    }
  }
}
