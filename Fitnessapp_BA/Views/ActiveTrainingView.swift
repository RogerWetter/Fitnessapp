//
//  ActiveTrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct ActiveTrainingView: View {
  
  @Bindable var training: Training
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Text("Hello, World!")
    Button {
      dismiss()
    } label: {
      Text("Close")
    }
  }
}

#Preview {
  ActiveTrainingView(training: Training())
    .modelContainer(for: Training.self, inMemory: true)
}
