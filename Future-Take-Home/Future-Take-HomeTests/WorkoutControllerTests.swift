//
//  WorkoutControllerTests.swift
//  Future-Take-HomeTests
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import XCTest

@testable import Future_Take_Home

class WorkoutControllerTests: XCTestCase {

    override func setUp() {
        // Nothing to do here for now.
    }

    override func tearDown() {
        // Nothing to do here for now.
    }

    func testWorkoutsController_OnInitLoadsData() {
        let sut = WorkoutsController()
        XCTAssertTrue(sut.workoutSummaries.isNotEmpty)
        XCTAssertTrue(sut.excerciseHistory.isNotEmpty)
    }
    
    func testWorkoutsController_VerifySortedExercises() {
        let sut = WorkoutsController()
        var previousExercise = ""
        for exercise in sut.getSortedExercises() {
            if previousExercise.isNotEmpty {
                XCTAssertTrue(previousExercise <= exercise.exerciseName!)
            }
            previousExercise = exercise.exerciseName!
        }
    }
}
