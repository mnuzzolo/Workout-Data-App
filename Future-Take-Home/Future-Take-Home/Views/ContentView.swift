//
//  ContentView.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var controller: WorkoutsController
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Text("**\(controller.totalCaloriesBurned)** calories burned!")
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.accent)
                    }
                }
                ForEach(Array(controller.getSortedExercises()), id: \.self) { exercise in
                    NavigationLink {
                        ExerciseDetailView(viewModel: ExerciseViewModel(sets: exercise))
                    } label: {
                        ExerciseListView(viewModel: ExerciseViewModel(sets: exercise))
                    }
                }
            }
            .navigationTitle(Text("Exercises"))
        }
    }
}

#Preview {
    ContentView(controller: WorkoutsController())
}
