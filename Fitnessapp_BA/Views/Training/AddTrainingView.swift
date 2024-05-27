//
//  addTrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 01.05.2024.
//

import SwiftUI

struct AddTrainingView: View {
  @Environment(\.modelContext) private var modelContext
  @State var name: String = ""
  @Environment(\.dismiss) var dismiss
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    NavigationView {
      TextField("Training Title", text: $name)
        .textFieldStyle(.plain)
        .padding()
        .navigationTitle("New Training")
        .navigationBarTitleDisplayMode(.inline)
        .focused($focusedField, equals: .field)
        .onAppear {
          self.focusedField = .field
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarLeading) {
            Button(action: {dismiss()}) {
              Text("Cancel")
            }
            .foregroundColor(.red)
          }
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: createTraining) {
              Text("Create")
                .fontWeight(name.isEmpty ? .regular : .semibold)
            }
            .disabled(name.isEmpty)
          }
        }
    }
  }
  
  private func createTraining() {
    let newTraining = Training(name: name)
    modelContext.insert(newTraining)
    dismiss()
  }
}

#Preview {
  AddTrainingView()
    .modelContainer(for: Training.self, inMemory: true)
}
