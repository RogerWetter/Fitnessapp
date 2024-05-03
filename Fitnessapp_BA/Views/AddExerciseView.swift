//
//  addExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct addExerciseView: View {
  @Environment(\.modelContext) private var modelContext
  @State var name: String = ""
  @Environment(\.dismiss) var dismiss
  @State private var isTextFieldFocused = false
  
  var body: some View {
    NavigationView {
      TextField("Name Trainingseinheit", text: $name)
        .textFieldStyle(.roundedBorder)
        .padding()
        .navigationTitle("Neue Trainingseinheit")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
          isTextFieldFocused = true
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button(action: dismissAction) {
              Text("Cancel")
            }
            .foregroundColor(.red)
          }
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: createTraining) {
              Text("Create")
            }
            .disabled(name.isEmpty)
            .keyboardShortcut(.defaultAction)
          }
        }
    }
  }
  
  private func dismissAction() {
    dismiss()
  }
  
  private func createTraining() {
    let newTraining = Training(name: name)
    modelContext.insert(newTraining)
    dismiss()
  }
}

#Preview {
    addExerciseView()
    .modelContainer(for: Training.self, inMemory: true)
}
