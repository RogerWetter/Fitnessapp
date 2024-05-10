//
//  ContentView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 29.04.2024.
//

import SwiftUI

struct ContentView: View {
  @State private var path = NavigationPath()
  
  var body: some View {
    TabView {
      
      NavigationStack(path: $path) {
        HomeView()
      }
      .tabItem {
        Label(
          title: { Text("Home") },
          icon: { Image(systemName: "house.fill") }
        )
      }
      
      NavigationStack {
        AnalyseView()
      }
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
