//
//  ExerciseListItemViewModel.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import Foundation

extension TimeInterval {
    static let oneDay = TimeInterval(86_400)
}

class ExerciseViewModel: ObservableObject {
    let sets: [ExerciseSetSummary]
    
    init(sets: [ExerciseSetSummary]) {
        self.sets = sets
    }
    
    public var sortedSets: [ExerciseSetSummary] {
        return sets.sorted(by: { $0.completedAt ?? Date() > $1.completedAt ?? Date() })
    }
    
    public var displayName: String {
        if let hand = self.hand {
            return "\(self.name) - \(hand)"
        } else {
            return name
        }
    }
    
    public var name: String {
        // We should be able to grab the Name for the exercise from any exercise in the set
        self.sets.first?.exerciseSet?.exercise?.name ?? "Unkown Exercise"
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
    
    // Get the max weight for given sets
    func maxWeightInSets(sets: [ExerciseSetSummary]) -> Double {
        var maxWeight = 0.0
        for set in mostRecentSets {
            if Int(set.weight ?? 0) > Int(maxWeight) {
                maxWeight = Double(set.weight ?? 0.0)
            }
        }
        return maxWeight
    }
    
    // Calculate the weight progress from the least recent to most recent sets
    var weightProgress: Double {
        let mostRecentMaxWeight = maxWeightInSets(sets: mostRecentSets)
        let leastRecentMaxWeight = maxWeightInSets(sets: leastRecentSets)
        guard mostRecentMaxWeight != 0, leastRecentMaxWeight != 0 else {
            return 0
        }
        
        return (mostRecentMaxWeight / leastRecentMaxWeight) - 1
    }
    
    // Get the reps completed for given sets
    func repsInSets(sets: [ExerciseSetSummary]) -> Int {
        var reps = 0
        for set in sets {
            reps += set.repsCompleted ?? 0
        }
        return reps
    }

    // Calculate the reps progress from the least recent to most recent sets
    var repsProgress: Double {
        let mostRecentReps = repsInSets(sets: mostRecentSets)
        let leastRecentReps = repsInSets(sets: leastRecentSets)
        guard mostRecentReps != 0, leastRecentReps != 0 else {
            return 0
        }
        return (Double(mostRecentReps) / Double(leastRecentReps)) - 1.0
    }
}
