//
//  WorkoutData.swift
//  Workout-Data-App
//
//  Created by Mike Nuzzolo on 3/28/25.
//

protocol WorkoutData {
    func fetchWorkouts(sort: SortType, count: Int, lastWorkoutId: String?) async -> [[ExerciseSetSummary]]
    func getTotalCalories() -> Int
    func hasMoreData(count: Int) -> Bool
}
