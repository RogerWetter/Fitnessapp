//
//  SelectMuscleGroup.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 08.05.2024.
//

import SwiftUI
import SwiftData

struct SelectMuscleGroup: View {
  @Environment(\.modelContext) private var modelContext
  @Query private var allMuscleGroups: [MuscleGroup]
  
  @Binding var muscleGroups: [MuscleGroup]
  @State private var muscleGroupsToAdd: [MuscleGroup] = []
  
  @Environment(\.dismiss) var dismiss
  
  @State private var isCreateMuscleGroup = false
  @State private var newMuscleGroupName: String = ""
  @State private var newMuscleGroupColor: MuscleGroupColor = MuscleGroupColor.green
  let muscleGroupColors: [MuscleGroupColor] = MuscleGroupColor.allCases
  var body: some View {
    NavigationView {
      List {
        ForEach(allMuscleGroups) { muscleGroup in
          HStack {
            Text(muscleGroup.name)
            Spacer()
            Button {
              if muscleGroupsToAdd.contains(muscleGroup) {
                muscleGroupsToAdd.removeAll(where: {
                  $0 == muscleGroup
                })
              } else {
                muscleGroupsToAdd.append(muscleGroup)
              }
            } label: {
              Image(systemName: muscleGroupsToAdd.contains(muscleGroup) ? "checkmark.circle" : "plus.circle")
                .imageScale(.large)
            }
          }
        }
        if(isCreateMuscleGroup) {
          HStack {
            TextField("New Muscle Group", text: $newMuscleGroupName)
            Picker("Select the Color for the MuscleGroup", selection: $newMuscleGroupColor) {
              ForEach(muscleGroupColors, id: \.self) {
                Text($0.rawValue)
              }
            }
            Button("Create", systemImage: "plus") {
              modelContext.insert(MuscleGroup(name: newMuscleGroupName, color: newMuscleGroupColor.rawValue))
              newMuscleGroupName = ""
              newMuscleGroupColor = MuscleGroupColor.green
              isCreateMuscleGroup.toggle()
            }
          }
        } else {
          Button(action: createMuscleGroup, label: {
            Label("create new Muscle Group", systemImage: "plus")
          })
        }
      }
      .padding()
      .navigationTitle("Select Muscle Group")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button(action: dismissAction) {
            Text("Cancel")
          }
          .foregroundColor(.red)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: doneAction) {
            Text("Done")
              .fontWeight(.semibold)
          }
        }
      }
    }
  }
  
  private func dismissAction() {
    dismiss()
  }
  
  private func doneAction() {
    muscleGroups.append(contentsOf: muscleGroupsToAdd)
    dismiss()
  }
  
  private func createMuscleGroup() {
    isCreateMuscleGroup.toggle()
  }
}
//
//#Preview {
//  SelectMuscleGroup(muscleGroups: $muscleGroups)
//}
