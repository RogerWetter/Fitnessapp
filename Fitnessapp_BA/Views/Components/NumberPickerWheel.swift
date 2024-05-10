//
//  NumberPickerWheel.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 10.05.2024.
//

import SwiftUI

struct NumberPickerWheel: View {
  
  @Binding var number: Int
  
  @State var numberTextfield: String = ""
  @State var isShowingWheel = true
  
  var range: ClosedRange = 0...200
  
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    
    if isShowingWheel {
      HStack {
        Picker("", selection: $number) {
          ForEach(range, id: \.self) {
            Text(String($0))
          }
        }
        .onTapGesture {
          isShowingWheel.toggle()
        }
        .pickerStyle(.wheel)
        //        Button {
        //          isShowingWheel.toggle()
        //        } label: {
        //          Label("Edit", systemImage: "pencil")
        //        }
      }
    } else {
      HStack {
        TextField("", text: $numberTextfield)
          .keyboardType(.numberPad)
          .font(.title2)
          .multilineTextAlignment(.center)
          .textFieldStyle(.plain)
          .padding()
          .focused($focusedField, equals: .field)
          .onAppear {
            numberTextfield = String(number)
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
        //        Button {
        //          saveNumberTextfield()
        //        } label: {
        //          Label("Done", systemImage: "keyboard.chevron.compact.down")
        //        }
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
    
    
  }
  
  private func saveNumberTextfield() {
    focusedField = nil
    isShowingWheel.toggle()
    if let changedNumber = Int(numberTextfield) {
      number = min(max(changedNumber, range.lowerBound), range.upperBound)
    }
  }
  
}

//#Preview {
//  NumberPickerWheel(number: $XXX)
//}
