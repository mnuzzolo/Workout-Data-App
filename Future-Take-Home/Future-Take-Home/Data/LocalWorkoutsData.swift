//
//  LocalWorkoutsData.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/28/25.
//

import Foundation

class LocalWorkoutsData: WorkoutData {
    // Full workout summary data, provided by JSON files
    internal var workoutSummaries = [WorkoutSummary]()
    
    // Dictionary of Exercise Set data, stored by ID
    internal var excerciseHistory = [String: [ExerciseSetSummary]]()
    
    // Hold onto the decoder object
    private var decoder = JSONDecoder()
    
    // Empty init for now
    init() {}
    
    // Data fetching func -> Handles paging
    func fetchWorkouts(sort: SortType, count: Int, lastWorkoutId: String?) async -> [[ExerciseSetSummary]] {
        if workoutSummaries.isEmpty && excerciseHistory.isEmpty {
            localFetch()
        }
        let allData = getSortedExercises(sort: sort)
        if let id = lastWorkoutId {
            if let startIndex = allData.firstIndex(where: {  $0.id == id }) {
                // Make sure we don't overflow the bounds of the data
                let endIndex = min(allData.count, startIndex + count)
                return Array(allData[startIndex+1..<endIndex])
            } else {
                return []
            }
        } else {
            return Array(allData[0..<count])
        }
    }
    
    func localFetch() {
        let summaryUrls = Bundle.main.urls(forResourcesWithExtension: ".json", subdirectory: nil) ?? []
        
        // Populate workout summary data
        for summaryUrl in summaryUrls {
            if let workoutSummaryData = try? Data(contentsOf: summaryUrl),
               let workoutSummary = try? decoder.decode(WorkoutSummary.self, from: workoutSummaryData) {
                workoutSummaries.append(workoutSummary)
            }
        }

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
    }
    
    // Return a calculation of total calories in all workouts
    func getTotalCalories() -> Int {
        return workoutSummaries.totalCaloriesBurned
    }
    
    // Return if there are more items to load than the count
    func hasMoreData(count: Int) -> Bool {
        return count < excerciseHistory.count
    }
    
    // Handle sorting
    func getSortedExercises(sort: SortType) -> [[ExerciseSetSummary]] {
        return excerciseHistory.values.sorted {
            switch sort {
            case .alphabetical:
                if let lhs = $0.first, let rhs = $1.first {
                    if lhs == rhs {
                        return lhs.exerciseSet?.exercise?.sideDisplayName ?? "" < rhs.exerciseSet?.exercise?.sideDisplayName ?? ""
                    }
                    return lhs > rhs
                }
            case .mostSets:
                return $0.count > $1.count
            default:
                // TODO: we can update to add more types of sorts
                return false
            }
            return false
        }
    }
}
