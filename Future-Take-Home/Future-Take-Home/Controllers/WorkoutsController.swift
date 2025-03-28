//
//  WorkoutsController.swift
//  Future
//
//

import Foundation

extension Int {
    static let pageSize = 5
}

public class WorkoutsController: ObservableObject {

    // Sorted array of ExerciseSetSummary arrays (alphabetically)
    @Published var sortedExercises = [[ExerciseSetSummary]]()
    
    @Published var totalCalories = 0
    
    @Published var hasMoreData = true
    
    @Published var sortType = SortType.alphabetical {
        didSet {
            // When we change sort type, clear our data
            sortedExercises = []
            Task {
                await fetchWorkouts()
            }
        }
    }
    
    internal var source: any WorkoutData
    
    init(loadData: Bool = true, source: any WorkoutData = LocalWorkoutsData()) {
        self.source = source
        if loadData {
            Task {
                await fetchWorkouts()
            }
        }
    }

    public func fetchWorkouts(count: Int = 5, lastWorkoutId: String? = nil) async {
        // Fake a delay to show paging
        try? await Task.sleep(for: .seconds(0.25))

        let newData = await source.fetchWorkouts(sort: self.sortType, count: count, lastWorkoutId: lastWorkoutId)
        await MainActor.run {
            self.sortedExercises.append(contentsOf: newData)
            self.totalCalories = source.getTotalCalories()
            self.hasMoreData = source.hasMoreData(count: sortedExercises.count)
        }
    }
}
