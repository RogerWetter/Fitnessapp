//
//  ExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 15.05.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct ExerciseView: View {
  
  @Binding var exercise: Exercise
  
  @State var isShowingEdit = false
  
  @State private var isShowingPhotosPicker = false
  @State private var isShowingCamera = false
  @State private var isShowingSelectMuscleGroup = false
  @State var selectedPhoto: PhotosPickerItem?
  
  var body: some View {
    if isShowingEdit {
      EditExerciseView(exercise: $exercise, isShowingEdit: $isShowingEdit)
    } else {
      ScrollView {
        if let image = exercise.image {
          Image(uiImage: UIImage(data: image)!)
            .resizable()
            .cornerRadius(30)
            .frame(width: 300, height: 300, alignment: .center)
            .clipped()
            .padding()
        } else {
          //            Rectangle()
          //              .cornerRadius(30)
          //              .frame(width: 300, height: 300)
          //              .clipped()
          //              .padding()
          Menu {
            Button {
              isShowingCamera.toggle()
            } label: {
              Label("Take Photo", systemImage: "camera")
            }
            Button {
              isShowingPhotosPicker.toggle()
            } label: {
              Label("Choose Photo", systemImage: "photo.on.rectangle")
            }
            //          Button {
            //
            //          } label: {
            //            Label("Choose File", systemImage: "folder")
            //          }
          } label: {
            Image(systemName: "camera.circle.fill")
              .resizable()
              .scaleEffect(0.3, anchor: .center)
              .symbolRenderingMode(.palette)
              .foregroundStyle(.white, .primary)
          }
          .frame(width: 300, height: 300)
          .background(.secondary)
          .cornerRadius(30)
        }
        
        Text(exercise.name).font(.title)
        
        Divider()
        
        TextField("Notes", text: $exercise.notes, axis: .vertical)
          .lineLimit(10)
        
        Divider()
        
        MuscleGroupRow(muscleGroups: exercise.muscleGroups)
        
        if let device = exercise.device {
          Text(device)
            .font(.caption)
        }
        
        Divider()
        
        ExerciseNumberView(numberOpt: exercise.weight, sysImage: "scalemass", name: "Weight", unit: "kg")
        
        ExerciseNumberView(numberOpt: exercise.repetitions, sysImage: "arrow.clockwise", name: "Repetitions", unit: "x")
        
        ExerciseNumberView(numberOpt: exercise.sets, sysImage: "arrow.triangle.2.circlepath", name: "Sets", unit: "x")
        
        ExerciseNumberView(numberOpt: exercise.setTime, sysImage: "clock.arrow.2.circlepath", name: "Set Time", unit: "min")
        
        ExerciseNumberView(numberOpt: exercise.setPause, sysImage: "pause", name: "Set Pause", unit: "min")
        
      }
      .photosPicker(isPresented: $isShowingPhotosPicker, selection: $selectedPhoto, matching: .images)
      .task(id: selectedPhoto) {
        if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
          exercise.image = data
        }
        
      }
      .fullScreenCover(isPresented: $isShowingCamera) {
        CameraPickerView() { uiImage in
          exercise.image = uiImage.pngData()
        }
      }
      .frame(alignment: .top)
      .padding(.horizontal)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Menu(content: {
            Button {
              isShowingEdit.toggle()
            } label: {
              Label("Edit", systemImage: "pencil")
            }
            Button {
              // TODO
            } label: {
              Label("Add to Training", systemImage: "text.badge.plus")
            }
            Button(role: .destructive) {
              // TODO
            } label: {
              Label("Delete", systemImage: "trash")
            }
          }, label: {
            Label("menu", systemImage: "ellipsis.circle.fill")
          })
        }
      }
    }
  }
  
}

struct ExerciseNumberView: View {
  let numberOpt: Int?
  let sysImage: String
  let name: String
  let unit: String
  
  var body: some View {
    if let number = numberOpt {
      HStack {
        Image(systemName: sysImage)
          .frame(width: 40)
        Text("\(name):")
        Spacer()
        Text(String(number))
          .multilineTextAlignment(.trailing)
          .frame(minWidth: 43, alignment: .trailing)
        Text(unit)
          .multilineTextAlignment(.leading)
          .frame(minWidth: 40, alignment: .leading)
      }
    }
  }
}

#Preview {
  ExerciseView(exercise: .constant(Exercise(name: "Name", notes: "NOtes", device: "Device" , weight: 55, repetitions: 5, sets: 2, setPause: 3, setTime: 3, image: UIImage(named: "Brustzug")?.pngData())))
}

#Preview("no Picture") {
  ExerciseView(exercise: .constant(Exercise(name: "Name", notes: "NOtes", device: nil, weight: 55, repetitions: 11, sets: 4, setPause: nil, setTime: nil, image: nil)))
}
