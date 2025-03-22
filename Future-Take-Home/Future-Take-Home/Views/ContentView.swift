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
                headerView
                Section("Exercises") {
                    ForEach(Array(controller.getSortedExercises()), id: \.self) { exercise in
                        NavigationLink {
                            ExerciseDetailView(viewModel: ExerciseViewModel(sets: exercise))
                        } label: {
                            ExerciseListView(viewModel: ExerciseViewModel(sets: exercise))
                        }
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
                        .padding(.bottom, 2)
                    HStack {
                        Text("**\(controller.totalCaloriesBurned)** calories burned")
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.accent)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(controller: WorkoutsController())
}
