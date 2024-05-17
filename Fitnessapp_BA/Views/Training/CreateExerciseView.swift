//
//  CreateExercise.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI
import SwiftData
import PhotosUI

struct CreateExerciseView: View {
  @Environment(\.modelContext) private var modelContext
  
  var exercisesToAdd: Binding<[Exercise]>?
  
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
  
  @Environment(\.dismiss) var dismiss
  
  @State private var isShowingPhotosPicker = false
  @State private var isShowingCamera = false
  @State private var isShowingSelectMuscleGroup = false
  
  enum FocusField: Hashable {
    case field
  }
  @FocusState private var focusedField: FocusField?
  
  var body: some View {
    NavigationView {
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
      .padding()
      .navigationTitle("New Exercise")
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItemGroup(placement: .navigationBarLeading) {
          Button {
            dismiss()
          } label: {
            Text("Cancel")
          }
          .foregroundColor(.red)
        }
        ToolbarItemGroup(placement: .navigationBarTrailing) {
          Button(action: createExercise) {
            Text("Create")
              .fontWeight(name.isEmpty ? .regular : .semibold)
          }
          .disabled(name.isEmpty)
        }
      }
    }
    .photosPicker(isPresented: $isShowingPhotosPicker, selection: $selectedPhoto, matching: .images)
    .task(id: selectedPhoto) {
      if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
        imageData = data
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
  }
  
  private func createExercise() {
    let newExercise = Exercise(
      name: name,
      notes: notes,
      device: device.isEmpty ? nil : device,
      weight: weight == 0 ? nil : weight,
      muscleGroup: muscleGroups,
      repetitions: repetitions == 0 ? nil : repetitions,
      sets: sets == 0 ? nil : sets,
      setPause: setPause == 0 ? nil : setPause,
      setTime: setTime == 0 ? nil : setTime,
      image: imageData
    )
    modelContext.insert(newExercise)
    if exercisesToAdd != nil {
      exercisesToAdd!.wrappedValue.append(newExercise)
    }
    dismiss()
  }
}

#Preview {
  AddExerciseView(training: Training(name: "Test"))
}
