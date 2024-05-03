//
//  addTrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 01.05.2024.
//

import SwiftUI

struct addTrainingView: View {
  @Environment(\.modelContext) private var modelContext
  @State var name: String = ""
  @Environment(\.dismiss) var dismiss
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    NavigationView {
      TextField("Name Trainingseinheit", text: $name)
        .textFieldStyle(.roundedBorder)
        .padding()
        .navigationTitle("New Training")
        .navigationBarTitleDisplayMode(.inline)
        .focused($focusedField, equals: .field)
        .onAppear {
          self.focusedField = .field
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
  addTrainingView()
    .modelContainer(for: Training.self, inMemory: true)
}
