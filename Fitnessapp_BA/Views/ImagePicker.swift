//
//  ImagePicker.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 02.05.2024.
//

import SwiftUI
import PhotosUI

class ImagePicker: ObservableObject {
  
  var image: Image? /*{
    didSet {
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }*/
  @Published var imageSelection: PhotosPickerItem? {
    didSet {
      if let imageSelection {
        Task {
          try await loadTransferable(from: imageSelection)
        }
      }
    }
  }
  
  func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
    do {
      if let image = try await imageSelection?.loadTransferable(type: Image.self) {
        self.image = image
      }
    } catch {
      print(error.localizedDescription)
      image = nil
    }
  }
  
  func getImage() -> Image? {
    return image
  }
}
