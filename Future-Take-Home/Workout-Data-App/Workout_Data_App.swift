//
//  Workout_Data_App.swift
//  Workout-Data-App
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUI
import SwiftData

@main
struct Workout_Data_App: App {
    private var controller = WorkoutsController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: controller)
        }
        .modelContainer(for: WorkoutSwiftDataItem.self)
    }
}
