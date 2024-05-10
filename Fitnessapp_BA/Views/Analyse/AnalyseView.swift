//
//  AnalyseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct AnalyseView: View {
  @State var testNumber: Int = 5
  var body: some View {
    Text("Analyse View")
    Text("Test Number: \(testNumber)")
    NumberPickerWheel(number: $testNumber)
  }
}

#Preview {
  AnalyseView()
}
