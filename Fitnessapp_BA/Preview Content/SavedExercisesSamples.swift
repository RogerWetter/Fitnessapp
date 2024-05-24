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
  static let exercise2 = Exercise(name: "Bizeps", device: nil, weight: 13, muscleGroup: [] , repetitions: 10, sets: 3, setPause: 3, setTime: nil, image: nil)
  
  static let lastWeek = Calendar.current.date(byAdding: .day, value: -2 * 1, to: Date.now)
  static let lastWeek1 = Calendar.current.date(byAdding: .day, value: -4 * 1, to: Date.now)
  static let lastWeek2 = Calendar.current.date(byAdding: .day, value: -7 * 1, to: Date.now)
  static let last2Week = Calendar.current.date(byAdding: .day, value: -7 * 2, to: Date.now)
  static let last3Week = Calendar.current.date(byAdding: .day, value: -7 * 3, to: Date.now)
  static let last4Week = Calendar.current.date(byAdding: .day, value: -7 * 4, to: Date.now)
  static let last5Week = Calendar.current.date(byAdding: .day, value: -7 * 5, to: Date.now)
  static let last6Week = Calendar.current.date(byAdding: .day, value: -7 * 6, to: Date.now)
  static let last7Week = Calendar.current.date(byAdding: .day, value: -7 * 7, to: Date.now)
  static let last8Week = Calendar.current.date(byAdding: .day, value: -7 * 8, to: Date.now)
  
  static var sampleSavedExercises: [SavedExercise] {
    [
      SavedExercise(exercise: exercise2, sets: [
        SavedSet(weight: 15, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 15, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 15, repetitions: 8, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: lastWeek ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 13, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 13, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 13, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: lastWeek1 ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 12, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 12, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 13, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: lastWeek2 ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 12, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 12, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 12, repetitions: 11, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last2Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 10, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 11, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last3Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last4Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last5Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 8, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 10, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last6Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 8, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 11, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last7Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil)
      ]),
      SavedExercise(timeStamp: last8Week ?? Date(timeIntervalSince1970: 0), exercise: exercise2, sets: [
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil),
        SavedSet(weight: 8, repetitions: 10, setPause: nil, setTime: nil)
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
