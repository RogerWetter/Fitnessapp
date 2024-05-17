//
//  ExerciseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 15.05.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditExerciseView: View {
  
  @Binding var exercise: Exercise
  
  @Binding var isShowingEdit: Bool
  
  @State var name: String = ""
  @State var notes: String = ""
  @State var device: String = ""
  @State var muscleGroups: [MuscleGroup] = []
  @State var weight: Int = 0
  @State var sets: Int = 3
  @State var repetitions: Int = 10
  @State var setPause: Int = 0
  @State var setTime: Int = 0
  
  @State var imageData: Data? = nil
  @State var image: Image? = nil
  @State var selectedPhoto: PhotosPickerItem?
  
  @State private var isShowingPhotosPicker = false
  @State private var isShowingCamera = false
  @State private var isShowingSelectMuscleGroup = false
  
  var body: some View {
    ScrollView {
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
      .frame(width: 200, height: 200)
      .background(
        Group {
          if let loadedImage = image {
            loadedImage
              .resizable()
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          } else {
            Color.secondary
          }
        }
      )
      .cornerRadius(20)
      
      ExerciseInputFieldsView(name: $name, notes: $notes, device: $device, muscleGroups: $muscleGroups, weight: $weight, repetitions: $repetitions, sets: $sets, setPause: $setPause, setTime: $setTime, isShowingSelectMuscleGroup: $isShowingSelectMuscleGroup)
      
    }
    .padding(.horizontal)
    .navigationTitle("Edit Exercise")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItemGroup(placement: .navigationBarLeading) {
        Button {
          isShowingEdit.toggle()
        } label: {
          Text("Cancel")
        }
        .foregroundColor(.red)
      }
      ToolbarItemGroup(placement: .navigationBarTrailing) {
        Button(action: editExercise) {
          Text("Done")
            .fontWeight(name.isEmpty ? .regular : .semibold)
        }
        .disabled(name.isEmpty)
      }
    }
    .photosPicker(isPresented: $isShowingPhotosPicker, selection: $selectedPhoto, matching: .images)
    .task(id: selectedPhoto) {
      if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
        imageData = data
//        if let uiImage = UIImage(data: imageData!) {
//          image = Image(uiImage: uiImage)
//        }
      }
    }
    .task(id: imageData) {
      if imageData != nil {
        if let uiImage = UIImage(data: imageData!) {
          image = Image(uiImage: uiImage)
        }
      }
    }
    .fullScreenCover(isPresented: $isShowingCamera) {
      CameraPickerView() { uiImage in
        imageData = uiImage.pngData()
        self.image = Image(uiImage: uiImage)
      }
    }
    .sheet(isPresented: $isShowingSelectMuscleGroup) {
      SelectMuscleGroup(muscleGroups: $muscleGroups).presentationDetents([.medium, .large])
    }
    .onAppear(perform: {
      name = exercise.name
      notes = exercise.notes
      device = exercise.device ?? ""
      weight = exercise.weight ?? 0
      repetitions = exercise.repetitions ?? 0
      sets = exercise.sets ?? 0
      setTime = exercise.setTime ?? 0
      setPause = exercise.setPause ?? 0
      muscleGroups = exercise.muscleGroups
      imageData = exercise.image
    })
  }
  
  
  private func editExercise() {
    exercise.name = name
    exercise.notes = notes
    exercise.device = device.isEmpty ? nil : device
    exercise.weight = weight == 0 ? nil : weight
    exercise.repetitions = repetitions == 0 ? nil : repetitions
    exercise.sets = sets == 0 ? nil : sets
    exercise.setTime = setTime == 0 ? nil : setTime
    exercise.setPause = setPause == 0 ? nil : setPause
    exercise.muscleGroups = muscleGroups
    exercise.image = imageData
    isShowingEdit.toggle()
  }
}

#Preview {
  EditExerciseView(exercise: .constant(Exercise(name: "Name", notes: "Die Übung mache ich immer mit 3? nein 4 schnaufern pro Zug...", device: "Device", weight: 55, repetitions: 10, sets: 2, setPause: 3, setTime: 3, image: UIImage(named: "Brustzug")?.pngData())), isShowingEdit: .constant(true))
}
#Preview("No Picture") {
  EditExerciseView(exercise: .constant(Exercise(name: "Name", notes: "NOtes", device: "Device", weight: 55, repetitions: 5, sets: 5, setPause: 3, setTime: 3, image: nil)), isShowingEdit: .constant(true))
}
