//
//  Future_Take_HomeApp.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUI
import SwiftData

@main
struct Future_Take_HomeApp: App {
    private var controller = WorkoutsController()
    
    var body: some Scene {
        WindowGroup {
            ContentView(controller: controller)
        }
    }
}
