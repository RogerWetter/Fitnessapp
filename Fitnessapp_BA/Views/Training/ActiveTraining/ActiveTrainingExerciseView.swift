//
//  ActiveTrainingExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 20.05.2024.
//

import SwiftUI

struct ActiveTrainingExerciseView: View {
  @EnvironmentObject var activeTrainingModel: ActiveTrainingModel
//  @Environment(\.dismiss) var dismiss
  var dismiss: DismissAction

  
    var body: some View {
      VStack(alignment: .leading) {
        HStack {
          if let device = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].device {
            Text(device)
              .font(.caption)
          }
          MuscleGroupRow(muscleGroups: activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].muscleGroups)
        }
        Text(activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].name).font(.title)
        HStack {
          if let weight = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].weight {
            Text("\(weight) kg")
              .font(.caption)
          }
          if let repetitions = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].repetitions {
            Text("\(repetitions) \(Image(systemName: "arrow.clockwise"))")
              .font(.caption)
          }
          if let sets = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].sets {
            Text("\(sets) \(Image(systemName: "arrow.triangle.2.circlepath"))")
              .font(.caption)
          }
          if let setTime = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].setTime {
            Text("\(setTime)' \(Image(systemName: "clock.arrow.2.circlepath"))")
              .font(.caption)
          }
          if let setPause = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].setPause {
            Text("\(setPause)' \(Image(systemName: "pause"))")
              .font(.caption)
          }
          
          
        }
        if let image = activeTrainingModel.training.exercises[activeTrainingModel.activeExercise].image {
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
        TextField("Notes", text: $activeTrainingModel.training.exercisesUnsorted[activeTrainingModel.activeExercise].notes, axis: .vertical)
              .lineLimit(10)
        Divider()
        Spacer()
        ForEach($activeTrainingModel.sets) { set in
          SetRow(set: set, sets: $activeTrainingModel.sets)
        }
        
        HStack {
          ActiveSetRow(training: activeTrainingModel.training, activeExercise: $activeTrainingModel.activeExercise, weight: $activeTrainingModel.weight, repetitions: $activeTrainingModel.repetitions, setPause: $activeTrainingModel.setPause)
          Spacer()
          if activeTrainingModel.isSetActive {
            Button {
              activeTrainingModel.endSet(set: SavedSet(weight: activeTrainingModel.weight, repetitions: activeTrainingModel.repetitions, setPause: activeTrainingModel.setPause))
              activeTrainingModel.saveSets()
            } label: {
              Label("End Set", systemImage: "stop.fill")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
          } else {
            Button {
              activeTrainingModel.startSet()
            } label: {
              Label("Start Set", systemImage: "play.fill")
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
          }
        }
        
        HStack {
          Spacer()
          Text("\(activeTrainingModel.activeExercise + 1)/\(activeTrainingModel.training.exercises.count)")
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 15, trailing: 0))
            .foregroundColor(Color(.systemGray))
          Spacer()
        }
        HStack {
          Button {
            activeTrainingModel.isShowingList.toggle()
          } label: {
            Label("Open List", systemImage: "list.bullet")
              .labelStyle(.iconOnly)
          }
          .padding()
          if activeTrainingModel.training.exercises.count > activeTrainingModel.activeExercise + 1 {
            Button {
              activeTrainingModel.forward()
            } label: {
              Label("Next Exercise", systemImage: "checkmark")
                .frame(maxWidth: .infinity)
                .font(.title2)
            }
            .buttonStyle(.bordered)
          } else {
            Button {
              activeTrainingModel.saveExercises()
              dismiss()
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

//#Preview {
//    ActiveTrainingExerciseView()
//}
