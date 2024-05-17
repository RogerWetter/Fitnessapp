//
//  ExerciseInputFieldsView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 16.05.2024.
//

import SwiftUI

struct ExerciseInputFieldsView: View {
  
  @Binding var name: String
  @Binding var notes: String
  @Binding var device: String
  @Binding var muscleGroups: [MuscleGroup]
  @Binding var weight: Int
  @Binding var repetitions: Int
  @Binding var sets: Int
  @Binding var setPause: Int
  @Binding var setTime: Int
  
  @Binding var isShowingSelectMuscleGroup: Bool
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    
    TextField("Exercise Name", text: $name, axis: .vertical)
      .font(.title)
      .multilineTextAlignment(.center)
      .lineLimit(2)
      .textFieldStyle(.plain)
      .padding()
      .focused($focusedField, equals: .field)
      .onAppear {
        self.focusedField = .field
      }
    
    Divider()
    
    TextField("Notes", text: $notes, axis: .vertical)
      .lineLimit(10)
    
    Divider()
    
    HStack {
      MuscleGroupRow(muscleGroups: muscleGroups)
        .scaledToFit()
      Button {
        isShowingSelectMuscleGroup.toggle()
      } label: {
        if muscleGroups.isEmpty {
          Label("Select Muscle Groups", systemImage: "plus")
        } else {
          Label("Select Muscle Groups", systemImage: "plus")
            .labelStyle(.iconOnly)
        }
      }
    }
    .padding(.vertical, 5)
    
    HStack {
      Text("Device:")
      TextField("Device", text: $device)
        .font(.title3)
        .padding(.horizontal, 8.0)
        .padding(.vertical, 2.0)
      .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
    }
    
    Divider()
    
    EditExerciseNumberRowView(number: $weight, sysImage: "scalemass", name: "Weight", unit: "kg")
    
    EditExerciseNumberRowView(number: $repetitions, sysImage: "arrow.clockwise", name: "Repetitions", unit: "x")
    
    EditExerciseNumberRowView(number: $sets, sysImage: "arrow.triangle.2.circlepath", name: "Sets", unit: "x")
    
//    EditExerciseNumberRowView(number: $setTime, sysImage: "clock.arrow.2.circlepath", name: "Set Time", unit: "min")
    
    EditExerciseNumberRowView(number: $setPause, sysImage: "pause", name: "Set Pause", unit: "min")
    
  }
}

#Preview {
  ExerciseInputFieldsView(name: .constant("Name"), notes: .constant("Notes zur Übung"), device: .constant("A99"), muscleGroups: .constant([MuscleGroup(name: "Test", color: "green")]), weight: .constant(55), repetitions: .constant(11), sets: .constant(3), setPause: .constant(3), setTime: .constant(5), isShowingSelectMuscleGroup: .constant(false))
}
#Preview("Überfüllt") {
  ExerciseInputFieldsView(name: .constant("MEEEGA langer Name aus igend einem Grund"), notes: .constant("EIN Riesiiiiger Text, um die ÜBung zu erklären? nein einfahc aus spass, oderso ähnlich oder wie seht ihr das? ich seh das so ähnlich... ich glaub es ist langsam nicht mehr so gut... so im allgemeinen.. mit mir undso... help... HELP!!!                         Oke han mi gfange... oder hani? bmmm smileys: 😂🥲😏🔵♟☺️❤️😅😒🛒🧸"), device: .constant("🤷🏽‍♂️"), muscleGroups: .constant([MuscleGroup(name: "Test", color: "green"), MuscleGroup(name: "Lange Muskelgruppe", color: "pink"), MuscleGroup(name: "Iwas", color: "cyan"), MuscleGroup(name: "1", color: "blue"), ]), weight: .constant(200), repetitions: .constant(0), sets: .constant(33), setPause: .constant(3), setTime: .constant(5), isShowingSelectMuscleGroup: .constant(false))
}
