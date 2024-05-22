//
//  ExerciseAnalyseView.swift
//  Fitnessapp_BA
//
//  Created by roger wetter on 21.05.2024.
//

import SwiftUI
import SwiftData
import Charts

struct ExerciseAnalyseView: View {
  let exercise: Exercise
  @Query(sort: \SavedExercise.timeStamp, order: .reverse) private var savedExercises: [SavedExercise]
  
  @State private var selectedTimePeriod: TimePeriod = .sevenDays
  
  enum TimePeriod: String, CaseIterable, Identifiable {
    case sevenDays = "7 Days"
    case oneMonth = "1 Month"
    case sixMonths = "6 Months"
    
    var id: String { self.rawValue }
    
    var dateRange: Date {
      let calendar = Calendar.current
      switch self {
      case .sevenDays:
        return calendar.date(byAdding: .day, value: -7, to: Date())!
      case .oneMonth:
        return calendar.date(byAdding: .month, value: -1, to: Date())!
      case .sixMonths:
        return calendar.date(byAdding: .month, value: -6, to: Date())!
      }
    }
    
    var dateRangeView: [Date] {
      let calendar = Calendar.current
      switch self {
      case .sevenDays:
        return [calendar.date(byAdding: .hour, value: -12, to: self.dateRange)!, calendar.date(byAdding: .hour, value: 12, to: Date())!]
      case .oneMonth:
        return [calendar.date(byAdding: .day, value: -1, to: self.dateRange)!, calendar.date(byAdding: .day, value: 1, to: Date())!]
      case .sixMonths:
        return [calendar.date(byAdding: .day, value: -7, to: self.dateRange)!, calendar.date(byAdding: .day, value: 7, to: Date())!]
      }
    }
    
    var stride: Calendar.Component {
      switch self {
      case .sevenDays:
        return .day
      case .oneMonth:
        return .weekOfYear
      case .sixMonths:
        return .month
      }
    }
    
    var dateFormat: String {
      switch self {
      case .sevenDays:
        return "MMM dd"
      case .oneMonth:
        return "'Week' w"
      case .sixMonths:
        return "MMM yy"
      }
    }
  }
  
  var filteredExercises: [SavedExercise] {
    let startDate = selectedTimePeriod.dateRange
    return savedExercises.filter { $0.exercise?.id == exercise.id && $0.timeStamp >= startDate }
  }
  
  var aggregatedData: [Date: (averageWeight: Double, totalWeight: Int)] {
    var data: [Date: (averageWeight: Double, totalWeight: Int)] = [:]
    let calendar = Calendar.current
    
    for exercise in filteredExercises {
      let normalizedDate: Date
      switch selectedTimePeriod {
      case .sevenDays:
        normalizedDate = calendar.startOfDay(for: exercise.timeStamp)
      case .oneMonth:
        let weekOfYear = calendar.component(.weekOfYear, from: exercise.timeStamp)
        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: exercise.timeStamp)
        normalizedDate = calendar.date(from: DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: yearForWeekOfYear))!
      case .sixMonths:
        let month = calendar.component(.month, from: exercise.timeStamp)
        let year = calendar.component(.year, from: exercise.timeStamp)
        normalizedDate = calendar.date(from: DateComponents(year: year, month: month))!
      }
      
      let weightSum = exercise.sets.compactMap { $0.weight }.reduce(0, +)
      let setCount = exercise.sets.count
      let averageWeight = setCount > 0 ? Double(weightSum) / Double(setCount) : 0.0
      
      let totalWeight = exercise.sets.compactMap { set -> Int? in
        if let weight = set.weight, let repetitions = set.repetitions {
          return weight * repetitions
        } else {
          return nil
        }
      }.reduce(0, +)
      
      if var existingData = data[normalizedDate] {
        existingData.averageWeight = (existingData.averageWeight + averageWeight) / 2
        existingData.totalWeight += totalWeight
        data[normalizedDate] = existingData
      } else {
        data[normalizedDate] = (averageWeight, totalWeight)
      }
    }
    
    let startDate = selectedTimePeriod.dateRange
    let endDate = Date()
    var date = startDate
    
    while date <= endDate {
      let normalizedDate: Date
      switch selectedTimePeriod {
      case .sevenDays:
        normalizedDate = calendar.startOfDay(for: date)
      case .oneMonth:
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        let yearForWeekOfYear = calendar.component(.yearForWeekOfYear, from: date)
        normalizedDate = calendar.date(from: DateComponents(weekOfYear: weekOfYear, yearForWeekOfYear: yearForWeekOfYear))!
      case .sixMonths:
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        normalizedDate = calendar.date(from: DateComponents(year: year, month: month))!
      }
      
      if data[normalizedDate] == nil {
        data[normalizedDate] = (0.0, 0)
      }
      date = calendar.date(byAdding: selectedTimePeriod.stride, value: 1, to: date)!
    }
    
    return data
  }
  
  func formattedDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = selectedTimePeriod.dateFormat
    return formatter.string(from: date)
  }
  
  var body: some View {
    ScrollView {
      Picker("", selection: $selectedTimePeriod) {
        ForEach(TimePeriod.allCases, id: \.self) {
          Text($0.rawValue)
        }
      }
      .pickerStyle(.segmented)
      .padding()
      
      if !aggregatedData.isEmpty {
        HStack {
          Text("Weight")
            .font(.headline)
            .bold()
          Spacer()
        }
        
        Chart {
          ForEach(aggregatedData.keys.sorted(), id: \.self) { date in
            if let data = aggregatedData[date] {
              BarMark(
                x: .value("Date", date),
                y: .value("Weight", data.averageWeight)
              )
            }
          }
        }
        .chartXScale(domain: selectedTimePeriod.dateRangeView)
        .chartXAxis {
          AxisMarks(values: .automatic)
        }
        .chartYAxis {
          AxisMarks(values: .automatic)
        }
        .frame(minHeight: 250)
        .padding()
        
        HStack {
          Text("Total Weight")
            .font(.headline)
            .bold()
          Spacer()
        }
        
        Chart {
          ForEach(aggregatedData.keys.sorted(), id: \.self) { date in
            if let data = aggregatedData[date] {
              BarMark(
                x: .value("Date", date),
                y: .value("Weight", data.totalWeight)
              )
            }
          }
        }
        .chartXAxis {
          AxisMarks(values: .automatic)
        }
        .chartYAxis {
          AxisMarks(values: .automatic)
        }
        .frame(minHeight: 250)
        .padding()
      } else {
        Text("No data available for this exercise.")
          .padding()
      }
      
      Spacer()
    }
    .padding(.horizontal)
    .navigationTitle("\(exercise.name) Analysis")
  }
}

#Preview {
  let preview = Preview()
  preview.addExamples(SavedExercise.sampleSavedExercises)
  return NavigationView {
    ExerciseAnalyseView(exercise: SavedExercise.exercise1)
      .modelContainer(preview.container)
  }
}
