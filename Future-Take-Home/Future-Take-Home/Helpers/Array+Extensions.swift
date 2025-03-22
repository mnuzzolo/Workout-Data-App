//
//  Array+Extensions.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//

extension Array where Element == ExerciseSetSummary {
    
    // Find the max weight for given sets
    var maxWeight: Double {
        var maxWeight = 0.0
        for set in self {
            if Int(set.weight ?? 0) > Int(maxWeight) {
                maxWeight = Double(set.weight ?? 0.0)
            }
        }
        return maxWeight
    }
    
    // Get the reps completed for given sets
    var totalReps: Int {
        var reps = 0
        for set in self {
            reps += set.repsCompleted ?? 0
        }
        return reps
    }
    
    var exerciseName: String? {
        // We should be able to grab the Name for the exercise from any exercise in the set
        self.first?.exerciseSet?.exercise?.name
    }
}

extension Array where Element == WorkoutSummary {
    // Calculate the sum of all calories burned in these workouts
    var totalCaloriesBurned: Int {
        var calories = 0
        for workout in self {
            calories += workout.activeEnergyBurned ?? 0
        }
        return calories
    }
}
