//
//  ActiveTrainingView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI

struct ActiveTrainingView: View {
  @Environment(\.modelContext) private var modelContext
  
  @Bindable var training: Training
  
  @State var activeExercise: Int = 0
  
  @State var weight: Int = 0
  @State var repetitions: Int = 10
  
  @State var isSetActive = false
  
  @State var savedExercises: [SavedExercise] = []
  @State var sets: [SavedSet] = []
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      VStack {
        VStack(alignment: .leading) {
          HStack {
            if let device = training.Exercises[activeExercise].device {
              Text(device)
                .font(.caption)
            }
            MuscleGroupRow(muscleGroups: training.Exercises[activeExercise].muscleGroups)
          }
          Text(training.Exercises[activeExercise].name).font(.title)
          HStack {
            if let weight = training.Exercises[activeExercise].weight {
              Text("\(weight) kg")
                .font(.caption)
            }
            if let repetitions = training.Exercises[activeExercise].repetitions {
              Text("\(repetitions) \(Image(systemName: "arrow.clockwise"))")
                .font(.caption)
            }
            if let sets = training.Exercises[activeExercise].sets {
              Text("\(sets) \(Image(systemName: "arrow.triangle.2.circlepath"))")
                .font(.caption)
            }
            if let setTime = training.Exercises[activeExercise].setTime {
              Text("\(setTime)' \(Image(systemName: "clock.arrow.2.circlepath"))")
                .font(.caption)
            }
            if let setPause = training.Exercises[activeExercise].setPause {
              Text("\(setPause)' \(Image(systemName: "pause"))")
                .font(.caption)
            }
            
            
          }
          if let image = training.Exercises[activeExercise].image {
//            GeometryReader { geometry in
//              Image(uiImage: UIImage(data: image)!)
//                .resizable()
//                .cornerRadius(30)
//                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .center)
//                .clipped()
//            }
//            .scaledToFit()
            HStack {
              Spacer()
              Image(uiImage: UIImage(data: image)!)
                .resizable()
                .cornerRadius(30)
                .frame(width: 200, height: 200, alignment: .center)
                .clipped()
              Spacer()
            }
          } else {
            Spacer()
          }
          
          ForEach($sets) { set in
            SetRow(set: set)
          }
          
          HStack {
            ActiveSetRow(training: training, activeExercise: $activeExercise, weight: $weight, repetitions: $repetitions)
            Spacer()
            if isSetActive {
              Button {
                endSet(set: SavedSet(weight: weight, repetitions: repetitions))
              } label: {
                Label("End Set", systemImage: "stop.fill")
              }
              .buttonBorderShape(.capsule)
              .buttonStyle(.borderedProminent)
            } else {
              Button {
                startSet()
              } label: {
                Label("Start Set", systemImage: "play.fill")
              }
              .buttonBorderShape(.capsule)
              .buttonStyle(.borderedProminent)
            }
          }
          Spacer()
          Button {
            markAsCompleted()
          } label: {
            Label("Exercise completed", systemImage: "checkmark")
              .frame(maxWidth: .infinity)
          }
          .tagStyle(savedExercises.first(where: { $0.exercise == training.Exercises[activeExercise] })?.completed != nil ? savedExercises.first(where: { $0.exercise == training.Exercises[activeExercise] })!.completed ? TagButtonStyle.prominent : TagButtonStyle.bordered : TagButtonStyle.bordered)
        }
        
        Text("\(activeExercise + 1)/\(training.Exercises.count)")
          .padding(EdgeInsets(top: 5, leading: 0, bottom: 15, trailing: 0))
          .foregroundColor(Color(.systemGray))
        HStack {
          Button {
            // List Öffnen
          } label: {
            Label("Open List", systemImage: "list.bullet")
              .frame(maxWidth: .infinity)
          }
          Button {
            backward()
          } label: {
            Label("Backward Exercise", systemImage: "backward.fill")
              .frame(maxWidth: .infinity)
          }
          .disabled(activeExercise < 1)
          if activeExercise + 1 < training.Exercises.count {
            Button {
              forward()
            } label: {
              Label("Forward Exercise", systemImage: "forward.fill")
                .frame(maxWidth: .infinity)
            }
          } else {
            Button {
              stopTraining()
            } label: {
              Label("Stop Training", systemImage: "stop.fill")
                .frame(maxWidth: .infinity)
            }
          }
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
        .buttonBorderShape(.automatic)
        .labelStyle(.iconOnly)
      }
      .padding()
      .navigationTitle(training.name)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem {
          Button {
            stopTraining()
          } label: {
            Label("Training beenden", systemImage: "stop.fill")
          }
        }
      }
    }
  }
  
  private func startSet() {
    isSetActive.toggle()
  }
  
  private func endSet(set: SavedSet) {
    sets.append(set)
    isSetActive.toggle()
  }
  
  private func markAsCompleted() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == training.Exercises[activeExercise] }) {
      savedExercises[existingSavedExerciseIndex].sets = sets
      savedExercises[existingSavedExerciseIndex].completed = true
    } else {
      let exercise = training.Exercises[activeExercise]
      let savedExercise = SavedExercise(exercise: nil, sets: sets)
      modelContext.insert(exercise)
      savedExercise.exercise = exercise
      savedExercise.completed = true
      savedExercises.append(savedExercise)
    }
    nextExercise()
    loadSets()
  }
  
  
  private func stopTraining() {
    saveSets()
    for savedExercise in savedExercises {
      modelContext.insert(savedExercise)
    }
    dismiss()
  }
  
  private func backward() {
    saveSets()
    if activeExercise > 0 {
      activeExercise -= 1
    }
    loadSets()
  }
  
  private func forward() {
    saveSets()
    nextExercise()
    loadSets()
  }
  
  private func nextExercise() {
    if activeExercise + 1 < training.Exercises.count {
      activeExercise += 1
    }
  }
  
  private func saveSets() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == training.Exercises[activeExercise] }) {
      savedExercises[existingSavedExerciseIndex].sets = sets
    } else {
      // I am afraid, this has to be like this
      let exercise = training.Exercises[activeExercise]
      let savedExercise = SavedExercise(exercise: nil, sets: sets)
      modelContext.insert(exercise)
      savedExercise.exercise = exercise
      savedExercises.append(savedExercise)
    }
  }
  
  private func loadSets() {
    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == training.Exercises[activeExercise] }) {
      sets = savedExercises[existingSavedExerciseIndex].sets
    } else {
      sets = []
    }
  }
}

//#Preview {
//  ActiveTrainingView(training: Training(name: "Test"))
//    .modelContainer(for: Training.self, inMemory: true)
//}
