//
//  ContentView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      
      NavigationStack {
        HomeView()
          .navigationDestination(for: Training.self) {
            training in
            TrainingView(training: training)
          }
      }
      .tabItem {
        Label(
          title: { Text("Home") },
          icon: { Image(systemName: "house.fill") }
        )
      }
      AnalyseView()
        .tabItem {
          Label(
            title: { Text("Analyse") },
            icon: { Image(systemName: "chart.bar.fill") }
          )
        }
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Training.self, inMemory: true)
}
