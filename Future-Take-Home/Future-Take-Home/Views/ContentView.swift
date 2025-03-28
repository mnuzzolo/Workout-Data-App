//
//  ContentView.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUI
import SwiftData

// Main View of the app - displays a header with calorie data
// and a list of Exercises that have been completed that can be navigated to.
struct ContentView: View {
    @ObservedObject var controller: WorkoutsController
    
    var body: some View {
        NavigationStack {
            List {
                headerView
                sortView
                Section("Exercises") {
                    ForEach(Array(controller.sortedExercises), id: \.self) { exercise in
                        NavigationLink {
                            ExerciseDetailView(viewModel: ExerciseViewModel(sets: exercise))
                        } label: {
                            ExerciseListView(viewModel: ExerciseViewModel(sets: exercise))
                        }
                        // Display a progress view when we are loading data
                        progressView(exercise: exercise)
                    }
                }
            }
            .navigationTitle(Text("Your Exercises"))
            
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        Section("Energy") {
            HStack {
                Spacer()
                VStack(alignment: .center) {
                    Text("Great work!")
                        .bold()
                        .font(.system(size: 26))
                        .padding(.bottom, 1)
                    HStack(spacing: 0) {
                        if controller.totalCalories == 0 {
                            ProgressView()
                        } else {
                            Text("**\(String.longNum(controller.totalCalories))**")
                        }
                        Text(" calories burned")
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.accent)
                            .padding(4)
                    }
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    var sortView: some View {
        Picker("Sort workouts by:", selection: $controller.sortType) {
            Text("Alphabetical").tag(SortType.alphabetical)
            Text("Most Sets").tag(SortType.mostSets)
            Text("Most Recent").tag(SortType.mostRecent)
        }
    }
    
    @ViewBuilder
    func progressView(exercise: [ExerciseSetSummary]) -> some View {
        if exercise == controller.sortedExercises.last && controller.hasMoreData {
            ProgressView()
                .onAppear() {
                    Task {
                        await controller.fetchWorkouts(lastWorkoutId: exercise.id)
                    }
                }
        }
    }
}

#Preview {
    ContentView(controller: WorkoutsController())
}
