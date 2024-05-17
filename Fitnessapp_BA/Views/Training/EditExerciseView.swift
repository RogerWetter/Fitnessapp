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
  
  @State var name: String = ""
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
  
  @State private var isShowingEdit = false
  
  @State private var isShowingPhotosPicker = false
  @State private var isShowingCamera = false
  @State private var isShowingSelectMuscleGroup = false
  
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
          TextField("Exercise Name", text: $name)
            .font(.title)
            .multilineTextAlignment(.center)
            .textFieldStyle(.plain)
            .padding()
//            .focused($focusedField, equals: .field)
//            .onAppear {
//              self.focusedField = .field
//            }
          TextField("Device", text: $device)
            .font(.title2)
            .padding(.all, 8.0)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color(.systemGray4), lineWidth: 2))
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
          .padding(.vertical)
          HStack {
            Text("weight:")
            Spacer()
            EditNumberButton(number: $weight)
            Text("kg")
              .frame(width: 30)
          }
          HStack {
            Text("\(Image(systemName: "arrow.clockwise")) Repetitions:")
            Spacer()
            EditNumberButton(number: $repetitions)
            Text("x")
              .frame(width: 30)
          }
          HStack {
            Text("\(Image(systemName: "arrow.triangle.2.circlepath")) Sets:")
            Spacer()
            EditNumberButton(number: $sets)
            Text("x")
              .frame(width: 30)
          }
          HStack {
            Text("\(Image(systemName: "clock.arrow.2.circlepath")) Set Pause:")
            Spacer()
            EditNumberButton(number: $setPause)
            Text("min")
              .frame(width: 30)
          }
          HStack {
            Text("\(Image(systemName: "clock.arrow.2.circlepath")) Set Time:")
            Spacer()
            EditNumberButton(number: $setTime)
            Text("min")
              .frame(width: 30)
          }
        }
        .padding()
        .navigationTitle("Edit Exercise")
        .navigationBarTitleDisplayMode(.inline)
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
  
  
  private func editExercise() {
    exercise.name = name
    exercise.device = device
    exercise.weight = weight
    exercise.repetitions = repetitions
    exercise.sets = sets
    exercise.setTime = setTime
    exercise.setPause = setPause
    exercise.muscleGroups = muscleGroups
    isShowingEdit.toggle()
  }
}

#Preview {
  ExerciseView(exercise: .constant(Exercise(name: "Name", device: "Device", weight: 55, setPause: 3, setTime: 3, image: UIImage(named: "Brustzug")?.pngData())))
}
