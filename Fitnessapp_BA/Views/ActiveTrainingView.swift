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
  
  @State var weight: Int?
  @State var repetitions: Int?
//  @State var setTime: Int?
  @State var setPause: Int?
  
  @State var isSetActive = false
  @State var isShowingList = false
  
  @State var savedExercises: [SavedExercise] = []
  @State var sets: [SavedSet] = []
  
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      if training.Exercises.isEmpty {
        VStack {
          Text("This Training has no Exercises Yet.")
          Button {
            dismiss()
          } label: {
            Text("Go Back")
          }
        }
      } else {
        VStack {
          if isShowingList {
            List(training.Exercises.indices, id: \.self) { idx in
              HStack {
                Button {
                  activeExercise = idx
                  isShowingList.toggle()
                } label: {
                  ExerciseRowActiveTraining(exercise: training.Exercises[idx], status: savedExercises.first(where: { $0.exercise == training.Exercises[idx] }))
                }
                .buttonStyle(.plain)
              }
            }
            HStack {
              Button {
                isShowingList.toggle()
              } label: {
                Label("Open List", systemImage: "list.bullet")
                  .labelStyle(.iconOnly)
              }
              .padding()
              Button {
                // Scan QR
              } label: {
                Label("Scan QR-Code", systemImage: "qrcode.viewfinder")
                  .labelStyle(.iconOnly)
              }
              .padding()
              Button {
                stopTraining()
              } label: {
                Text("End Training")
                  .frame(maxWidth: .infinity)
                  .font(.title2)
              }
              .buttonStyle(.bordered)
            }
            .padding(.horizontal)
          } else {
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
                HStack {
                  Spacer()
                  Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .cornerRadius(30)
                    .frame(width: 200, height: 200, alignment: .center)
                    .clipped()
                  Spacer()
                }
                .padding()
              } else {
                Spacer()
              }
              TextField("Notes", text: $training.Exercises[activeExercise].notes, axis: .vertical)
                    .lineLimit(10)
              Divider()
              Spacer()
              ForEach($sets) { set in
                SetRow(set: set, sets: $sets)
              }
              
              HStack {
                ActiveSetRow(training: training, activeExercise: $activeExercise, weight: $weight, repetitions: $repetitions, setPause: $setPause)
                Spacer()
                if isSetActive {
                  Button {
                    endSet(set: SavedSet(weight: weight, repetitions: repetitions, setPause: setPause))
                    saveSets()
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
              
              HStack {
                Spacer()
                Text("\(activeExercise + 1)/\(training.Exercises.count)")
                  .padding(EdgeInsets(top: 5, leading: 0, bottom: 15, trailing: 0))
                  .foregroundColor(Color(.systemGray))
                Spacer()
              }
              HStack {
                Button {
                  isShowingList.toggle()
                } label: {
                  Label("Open List", systemImage: "list.bullet")
                    .labelStyle(.iconOnly)
                }
                .padding()
                if training.Exercises.count > activeExercise + 1 {
                  Button {
                    forward()
//                    toggleCompleted(exercise: training.Exercises[activeExercise])
                  } label: {
                    Label("Next Exercise", systemImage: "checkmark")
                      .frame(maxWidth: .infinity)
                      .font(.title2)
                  }
                  .buttonStyle(.bordered)
                } else {
                  Button {
                    stopTraining()
                  } label: {
                    Label("End Training", systemImage: "checkmark")
                      .frame(maxWidth: .infinity)
                      .font(.title2)
                  }
                  .buttonStyle(.bordered)
                }
              }
            }
            .padding(.horizontal)
          }
        }
        .navigationTitle(training.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem {
            Button {
              stopTraining()
            } label: {
              Text("End")
                .fontWeight(.semibold)
            }
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
  
//  private func toggleCompleted(exercise: Exercise) {
//    if let existingSavedExerciseIndex = savedExercises.firstIndex(where: { $0.exercise == exercise }) {
//      savedExercises[existingSavedExerciseIndex].sets = sets
//      savedExercises[existingSavedExerciseIndex].completed.toggle()
//      if savedExercises[existingSavedExerciseIndex].completed {
//        nextExercise()
//      }
//    } else {
//      let exerciseToSave = exercise
//      let savedExercise = SavedExercise(exercise: nil, sets: sets)
//      modelContext.insert(exerciseToSave)
//      savedExercise.exercise = exerciseToSave
//      savedExercise.completed = true
//      savedExercises.append(savedExercise)
//      nextExercise()
//    }
//    loadSets()
//  }
  
  
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
    weight = training.Exercises[activeExercise].weight
    repetitions = training.Exercises[activeExercise].repetitions
//    setTime = training.Exercises[activeExercise].setTime
    setPause = training.Exercises[activeExercise].setPause
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
