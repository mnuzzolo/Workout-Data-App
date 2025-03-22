//
//  ArrayExtensionsTests.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//

import XCTest

@testable import Future_Take_Home

class ArrayExtensionsTests: XCTestCase {
    
    override func setUp() {
        // Nothing to do here for now.
    }
    
    override func tearDown() {
        // Nothing to do here for now.
    }
    
    func testArrayExerciseSetSummary_VerifyMaxWeight() {
        let controller = WorkoutsController()
        let sut = controller.getSortedExercises().first!
        let max = sut.compactMap( { $0.weight } ).max()
        XCTAssertEqual(sut.maxWeight, Double(max!))
    }
    
    func testArrayExerciseSetSummary_VerifyTotalReps() {
        let controller = WorkoutsController()
        let sut = controller.getSortedExercises().first!
        let sum = sut.compactMap( { $0.repsCompleted } ).reduce(0, +)
        XCTAssertEqual(sut.totalReps, sum)
    }
    
    func testArrayExerciseSetSummary_VerifyExerciseName() {
        let controller = WorkoutsController()
        let sut = controller.getSortedExercises().first!
        XCTAssertEqual(sut.exerciseName, sut.first?.exerciseSet?.exercise?.name)
    }
    
    func testArrayWorkouts_VerifyCalories() {
        let controller = WorkoutsController()
        let sut = controller.workoutSummaries
        let sum = sut.compactMap( { $0.activeEnergyBurned }).reduce(0, +)
        XCTAssertEqual(sut.totalCaloriesBurned, sum)
    }
}
