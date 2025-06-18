//
//  ExerciseListItemViewModel.swift
//  Workout-Data-App
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import Foundation

extension TimeInterval {
    static let oneDay = TimeInterval(86_400)
}

struct ExerciseViewModel {
    let sets: [ExerciseSetSummary]
    
    init(sets: [ExerciseSetSummary]) {
        self.sets = sets
    }
    
    public var sortedSets: [ExerciseSetSummary] {
        return sets.sortedByDate
    }
    
    public var displayName: String {
        if let hand = self.hand {
            return "\(self.name) - \(hand)"
        } else {
            return name
        }
    }
    
    public var name: String {
        self.sets.exerciseName ?? "Unkown Exercise"
    }
    
    public var hand: String? {
        self.sets.first?.exerciseSet?.exercise?.sideDisplayName
    }
    
    public var subtitle: String {
        "\(self.sets.count) Sets"
    }
    
    // Create the weight progress string we want to show the user
    public var weightProgressString: String {
        if weightProgress > 0 {
            return "+ \(Int(weightProgress * 100))%"
        } else if weightProgress < 0 {
            return "- \(abs(Int(weightProgress * 100)))%"
        } else {
            return "0%"
        }
    }
    
    // Create the reps progress string we want to show the user
    public var repsProgressString: String {
        if repsProgress > 0 {
            return "+ \(Int(repsProgress * 100))%"
        } else if repsProgress < 0 {
            return "- \(abs(Int(repsProgress * 100)))%"
        } else {
            return "0%"
        }
    }
}

// Handle calculating progress for the exercise
extension ExerciseViewModel {
    
    // Filter the data for the sets completed on the most recent day
    var mostRecentSets: [ExerciseSetSummary] {
        guard let mostRecentDate = self.sortedSets.first?.completedAt else {
            return []
        }
        return sets.filter({ Calendar.current.isDate($0.completedAt ?? Date(), inSameDayAs: mostRecentDate) })
    }
    
    // Filter the data for the sets completed on the least recent day
    var leastRecentSets: [ExerciseSetSummary] {
        guard let leastRecentDate = self.sortedSets.last?.completedAt else {
            return []
        }
        return sets.filter({ Calendar.current.isDate($0.completedAt ?? Date(), inSameDayAs: leastRecentDate) })
    }
    
    // Calculate the weight progress from the least recent to most recent sets
    var weightProgress: Double {
        let mostRecentMaxWeight = mostRecentSets.maxWeight
        let leastRecentMaxWeight = leastRecentSets.maxWeight
        guard mostRecentMaxWeight != 0, leastRecentMaxWeight != 0 else {
            return 0
        }
        
        return (mostRecentMaxWeight / leastRecentMaxWeight) - 1
    }

    // Calculate the reps progress from the least recent to most recent sets
    var repsProgress: Double {
        let mostRecentReps = mostRecentSets.totalReps
        let leastRecentReps = leastRecentSets.totalReps
        guard mostRecentReps != 0, leastRecentReps != 0 else {
            return 0
        }
        return (Double(mostRecentReps) / Double(leastRecentReps)) - 1.0
    }
}
