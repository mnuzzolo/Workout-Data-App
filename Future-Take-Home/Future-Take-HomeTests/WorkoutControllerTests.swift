//
//  WorkoutControllerTests.swift
//  Future-Take-HomeTests
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import XCTest

@testable import Future_Take_Home

class WorkoutControllerTests: XCTestCase {
    
    var sut: WorkoutsController!

    override func setUp() async throws {
        sut = WorkoutsController(loadData: false)
        await sut.fetchWorkouts()
    }

    override func tearDown() {
        // Nothing to do here for now.
    }

    func testWorkoutsController_OnInitLoadsData() {
        let data = sut.source as! LocalWorkoutsData
        XCTAssertTrue(data.workoutSummaries.isNotEmpty)
        XCTAssertTrue(data.excerciseHistory.isNotEmpty)
    }
    
    func testWorkoutsController_VerifySortedExercises() async {
        var previousExercise = ""
        for exercise in sut.sortedExercises {
            if previousExercise.isNotEmpty {
                XCTAssertTrue(previousExercise <= exercise.exerciseName!)
            }
            previousExercise = exercise.exerciseName!
        }
    }
}
