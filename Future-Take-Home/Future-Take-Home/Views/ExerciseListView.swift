//
//  ExerciseListView.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import SwiftUICore

struct ExerciseListView: View {
    @ObservedObject var viewModel: ExerciseViewModel
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
