//
//  ExerciseListView.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUICore

// List View item for a given exercise.
// Displays the name and number of sets recorded.
struct ExerciseListView: View {
    let viewModel: ExerciseViewModel
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.displayName)
                    .bold()
                Text(viewModel.subtitle)
                    .italic()
                    .foregroundStyle(.accent)
            }
        }
    }
}
