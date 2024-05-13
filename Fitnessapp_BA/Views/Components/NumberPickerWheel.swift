//
//  NumberPickerWheel.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct NumberPickerWheel: View {
  @Environment(\.dismiss) var dismiss
  
  @Binding var number: Int
  
  @State var numberEdit = 0
  @State var numberTextfield: String = ""
  @State var isShowingWheel = true
  
  var range: ClosedRange = 0...200
  
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    
    if isShowingWheel {
        Picker("", selection: $numberEdit) {
          ForEach(range, id: \.self) {
            Text(String($0))
          }
        }
        .onAppear(perform: {
          numberEdit = number
        })
        .onTapGesture {
          isShowingWheel.toggle()
        }
        .pickerStyle(.wheel)
    } else {
      HStack {
        TextField("", text: $numberTextfield)
          .frame(width: 300)
          .keyboardType(.numberPad)
          .font(.title2)
          .multilineTextAlignment(.center)
          .textFieldStyle(.plain)
          .padding()
          .focused($focusedField, equals: .field)
          .onAppear {
            numberTextfield = String(numberEdit)
            self.focusedField = .field
          }
          .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
            // Select all text when open
            if let textField = obj.object as? UITextField {
              textField.selectAll(nil)
            }
          }
          .onSubmit {
            saveNumberTextfield()
          }
      }
      .toolbar {
        ToolbarItem(placement: .keyboard) {
          Spacer()
        }
        ToolbarItem(placement: .keyboard) {
          Button {
            saveNumberTextfield()
          } label: {
            Label("Done", systemImage: "keyboard.chevron.compact.down")
              .labelStyle(.titleAndIcon)
          }
        }
      }
    }
    Divider()
    HStack {
      Button {
        numberEdit = number
      } label: {
        Text("Reset")
      }
      Spacer()
      Button {
        if !isShowingWheel {
          saveNumberTextfield()
        }
        number = numberEdit
        dismiss()
      } label: {
        Text("Done")
          .fontWeight(.semibold)
          
      }
    }
    .padding()
  }
  
  private func saveNumberTextfield() {
    focusedField = nil
    isShowingWheel.toggle()
    if let changedNumber = Int(numberTextfield) {
      numberEdit = min(max(changedNumber, range.lowerBound), range.upperBound)
    }
  }
  
}

#Preview {
  NumberPickerWheel(number: .constant(50))
}
