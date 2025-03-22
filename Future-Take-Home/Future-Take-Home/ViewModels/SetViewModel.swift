//
//  SetViewModel.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//

import Foundation

class SetViewModel: ObservableObject {
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
}
