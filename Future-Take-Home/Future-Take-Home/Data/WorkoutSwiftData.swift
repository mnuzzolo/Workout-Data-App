//
//  WorkoutSwiftData.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/28/25.
//

import SwiftData
import Foundation

@Model
class WorkoutSwiftDataItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    
    // Call @Query to access from View
    // @Environment(\.modelContext) private var context
    // context.insert
    // context.delete
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
