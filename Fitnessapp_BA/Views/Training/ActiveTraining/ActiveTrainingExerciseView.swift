//
//  ActiveTrainingExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 20.05.2024.
//

import SwiftUI

struct ActiveTrainingExerciseView: View {
  @EnvironmentObject var activeTrainingModel: ActiveTrainingModel
  var dismiss: DismissAction
  
  @State var isShowingEditNoteView = false
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        if let device = activeTrainingModel.exercise.device {
          Text(device)
            .font(.caption)
        }
        MuscleGroupRow(muscleGroups: activeTrainingModel.exercise.muscleGroups)
      }
      Text(activeTrainingModel.exercise.name).font(.title)
      HStack {
        if let weight = activeTrainingModel.exercise.weight {
          Text("\(weight) kg")
            .font(.caption)
        }
        if let repetitions = activeTrainingModel.exercise.repetitions {
          Text("\(repetitions) \(Image(systemName: "arrow.clockwise"))")
            .font(.caption)
        }
        if let sets = activeTrainingModel.exercise.sets {
          Text("\(sets) \(Image(systemName: "arrow.triangle.2.circlepath"))")
            .font(.caption)
        }
        if let setTime = activeTrainingModel.exercise.setTime {
          Text("\(setTime)' \(Image(systemName: "clock.arrow.2.circlepath"))")
            .font(.caption)
        }
        if let setPause = activeTrainingModel.exercise.setPause {
          Text("\(setPause)' \(Image(systemName: "pause"))")
            .font(.caption)
        }
        
        
      }
      if let image = activeTrainingModel.exercise.image {
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
      Button {
        isShowingEditNoteView.toggle()
      } label: {
        activeTrainingModel.exercise.notes.isEmpty ? Text("Notes") : Text(activeTrainingModel.exercise.notes)
      }
      .tagStyle(.plain)
      .foregroundStyle(activeTrainingModel.exercise.notes.isEmpty ? .gray : .primary)
      .sheet(isPresented: $isShowingEditNoteView, content: {
        EditNoteView(note: activeTrainingModel.editableExercise.notes)
          .presentationDetents([.medium])
      })
      Divider()
      Spacer()
      ScrollView {
        ForEach($activeTrainingModel.sets) { set in
          SetRow(set: set, sets: $activeTrainingModel.sets)
        }
      }
      .scrollBounceBehavior(.basedOnSize, axes: [.vertical])
      HStack {
        ActiveSetRow(exercise: activeTrainingModel.editableExercise)
        Spacer()
        if activeTrainingModel.isSetActive {
          Button {
            activeTrainingModel.endSet()
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
        Text("\(activeTrainingModel.exerciseNumber)/\(activeTrainingModel.training.exercises.count)")
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
        if activeTrainingModel.training.exercises.count > activeTrainingModel.exerciseNumber {
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
