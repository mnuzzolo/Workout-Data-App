//
//  SetViewModel.swift
//  Workout-Data-App
//
//  Created by Mike Nuzzolo on 3/22/25.
//

import Foundation

struct SetViewModel {
    let set: ExerciseSetSummary
    
    init(set: ExerciseSetSummary) {
        self.set = set
    }
    
    public var completionDate: String {
        return set.completedAt?.asString() ?? "Unknown date"
    }
    
    public var reps: String {
        return "\(set.repsCompleted ?? 0) reps"
    }
    
    public var weight: String {
        return "\(set.weight ?? 0) lbs"
    }
    
    public var timeSpentActive: String {
        return "\(String(set.timeSpentActive ?? 0)) seconds"
    }
}
