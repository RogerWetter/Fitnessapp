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
  }
  
  var filteredExercises: [SavedExercise] {
    let startDate = selectedTimePeriod.dateRange
    return savedExercises.filter { $0.exercise?.id == exercise.id && $0.timeStamp >= startDate } // nach ID oder name??
  }
  
  var body: some View {
    VStack {
      HStack {
        Text("Weight")
          .font(.headline)
          .bold()
        Spacer()
        Menu {
          ForEach(TimePeriod.allCases) { period in
            Button(action: {
              selectedTimePeriod = period
            }) {
              Text(period.rawValue)
            }
          }
        } label: {
          Label(selectedTimePeriod.rawValue, systemImage: "chevron.down")
        }
        .menuStyle(.automatic)
      }
      .padding()
      
      if !filteredExercises.isEmpty {
        Chart {
          ForEach(filteredExercises) { savedExercise in
            let weightSum = savedExercise.sets.compactMap { $0.weight }.reduce(0, +)
            let setCount = savedExercise.sets.count
            let averageWeight = setCount > 0 ? Double(weightSum) / Double(setCount) : 0.0
            
            BarMark(
              x: .value("Date", savedExercise.timeStamp),
              y: .value("Weight", averageWeight)
            )
          }
        }
        .chartXAxis {
          AxisMarks(values: .stride(by: .day)) { value in
            AxisValueLabel(format: .dateTime.month().day())
          }
        }
        .chartYAxis {
          AxisMarks(values: .automatic)
        }
        .padding()
      } else {
        Text("No data available for this exercise.")
          .padding()
      }
      
      Spacer()
    }
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
