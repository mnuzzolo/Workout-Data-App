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
        await sut.loadLocalData()
    }

    override func tearDown() {
        // Nothing to do here for now.
    }

    func testWorkoutsController_OnInitLoadsData() {
        XCTAssertTrue(sut.workoutSummaries.isNotEmpty)
        XCTAssertTrue(sut.excerciseHistory.isNotEmpty)
    }
    
    func testWorkoutsController_VerifySortedExercises() async {
        var previousExercise = ""
        for exercise in sut.getSortedExercises() {
            if previousExercise.isNotEmpty {
                XCTAssertTrue(previousExercise <= exercise.exerciseName!)
            }
            previousExercise = exercise.exerciseName!
        }
    }
}
