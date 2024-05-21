//
//  SavedExercisesSamples.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 21.05.2024.
//

import Foundation
import SwiftData

extension SavedExercise {
  static let exercise1 = Exercise(name: "Exercise 1", device: nil, weight: 35, repetitions: 10, sets: 3, setPause: nil, setTime: nil, image: nil)
  static let exercise2 = Exercise(name: "Exercise 2", device: nil, weight: 55, muscleGroup: [MuscleGroup(name: "Muscle Group", color: "green")] , repetitions: 11, sets: 3, setPause: nil, setTime: nil, image: nil)
  
  static let lastWeek = Calendar.current.date(byAdding: .day, value: -7 * 5, to: Date.now)
  static let last2Week = Calendar.current.date(byAdding: .day, value: -7 * 6, to: Date.now)
  static let last3Week = Calendar.current.date(byAdding: .day, value: -7 * 7, to: Date.now)
  static let last4Week = Calendar.current.date(byAdding: .day, value: -7 * 8, to: Date.now)
  
  static var sampleSavedExercises: [SavedExercise] {
    [
//      SavedExercise(exercise: exercise2, sets: [
//        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
//        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
//        SavedSet(weight: 60, repetitions: 11, setPause: nil, setTime: nil)
//      ]),
      SavedExercise(timeStamp: lastWeek ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last2Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last3Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 50, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 55, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last4Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 50, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 50, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 50, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(exercise: exercise1, sets: [
        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 35, repetitions: 11, setPause: nil, setTime: nil)
      ]),
//      SavedExercise(timeStamp: lastWeek ?? Date(timeIntervalSince1970: 0), exercise: exercise1, sets: [
//        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
//        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
//        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil)
//      ]),
//      SavedExercise(timeStamp: last2Week ?? Date(timeIntervalSince1970: 0), exercise: exercise1, sets: [
//        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
//        SavedSet(weight: 35, repetitions: 10, setPause: nil, setTime: nil),
//        SavedSet(weight: 35, repetitions: 8, setPause: nil, setTime: nil)
//      ]),
    ]
  }
}
