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
    NavigationStack {
        List {
          Section(header: Text("My Data")) {
            NavigationLink {
              NavigationView {
                List {
                }
              }
            } label: {
              Text("All Muscle Groups")
            }
          }
        }
        .navigationTitle("Settings")
    }
  }
}

#Preview {
  SettingsView()
}
