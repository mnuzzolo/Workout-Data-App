//
//  WorkoutsController.swift
//  Future
//
//

import Foundation

public class WorkoutsController: ObservableObject {
    
    // Full workout summary data, provided by JSON files
    private var workoutSummaries = [WorkoutSummary]()
    
    // Dictionary of Exercise Set data, stored by ID
    private var excerciseHistory = [String: [ExerciseSetSummary]]()
    
    init() {
        loadLocalData()
    }
    
    func loadLocalData() {
        let summaryUrls = Bundle.main.urls(forResourcesWithExtension: ".json", subdirectory: nil) ?? []
        
        // Populate workout summary data
        for summaryUrl in summaryUrls {
            if let workoutSummaryData = try? Data(contentsOf: summaryUrl),
               let workoutSummary = try? JSONDecoder().decode(WorkoutSummary.self, from: workoutSummaryData) {
                workoutSummaries.append(workoutSummary)
            }
        }

        print("Loaded \(workoutSummaries.count) workout summaries.")
        
        // Populate exercise set summary data by exercise
        for workout in workoutSummaries {
            for summary in workout.setSummaries {
                if let id = summary.exerciseSet?.exercise?.id {
                    if var arr = excerciseHistory[id] {
                        arr.append(summary)
                        excerciseHistory[id] = arr
                    } else {
                        excerciseHistory[id] = [summary]
                    }
                }
            }
        }
        
        print("Loaded \(excerciseHistory.values.count) exercises.")
    }
    
    func getSortedExercises() -> [[ExerciseSetSummary]] {
        return excerciseHistory.values.sorted {
            if let lhs = $0.first, let rhs = $1.first {
                if lhs == rhs {
                    return lhs.exerciseSet?.exercise?.sideDisplayName ?? "" < rhs.exerciseSet?.exercise?.sideDisplayName ?? ""
                }
                return lhs > rhs
            } else {
                return false
            }
        }
    }
    
    var totalCaloriesBurned: String {
        var calories = 0
        for workout in workoutSummaries {
            calories += workout.activeEnergyBurned ?? 0
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: calories as NSNumber) ?? ""
    }
}
