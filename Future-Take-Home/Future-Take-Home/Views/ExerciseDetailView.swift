//
//  ExerciseDetailView.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//

import SwiftUI

struct ExerciseDetailView: View {
    
    @ObservedObject var viewModel: ExerciseViewModel
    
    var body: some View {
        Text(viewModel.displayName)
            .font(.headline)
        List {
            Section("Progress") {
                headerView
            }
            Section("Most Recent") {
                ForEach(viewModel.sortedSets) { set in
                    setView(set: SetViewModel(set: set))
                }
            }
        }
    }
    
    @ViewBuilder
    func setView(set: SetViewModel) -> some View {
        VStack(alignment: .leading) {
            Text(set.completionDate)
                .bold()
            Text(set.reps)
                .foregroundStyle(.accent)
            Text(set.weight)
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        HStack {
            Spacer()
            VStack {
                Text("Weight")
                    .bold()
                Text(viewModel.weightProgressString)
                    .font(.system(size: 28))
                    .bold()
                    .foregroundStyle(viewModel.weightProgress > 0 ? .accent : .black)
            }
            Spacer()
            VStack {
                Text("Reps")
                    .bold()
                Text(viewModel.repsProgressString)
                    .font(.system(size: 28))
                    .bold()
                    .foregroundStyle(viewModel.repsProgress > 0 ? .accent : .black)
            }
            Spacer()
        }
    }
}
