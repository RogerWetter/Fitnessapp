//
//  SettingsView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct SettingsView: View {
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text("Change here the Settings!")
    Button {
      dismiss()
    } label: {
      Text("Close")
    }
  }
}

#Preview {
  SettingsView()
}
