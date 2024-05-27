//
//  EditNoteView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 27.05.2024.
//

import SwiftUI

struct EditNoteView: View {
  @Binding var note: String
  @Environment(\.dismiss) var dismiss
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    NavigationView {
      TextField("Notes", text: $note, axis: .vertical)
        .textFieldStyle(.roundedBorder)
        .lineLimit(10)
        .padding()
        .focused($focusedField, equals: .field)
        .onAppear {
          self.focusedField = .field
        }
        .toolbar {
          ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button(action: {dismiss()}) {
              Text("Done")
                .fontWeight(.semibold)
            }
          }
        }
    }
  }
}

#Preview {
  EditNoteView(note: .constant(""))
}
