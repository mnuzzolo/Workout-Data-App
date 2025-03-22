//
//  ArrayExtensionsTests.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//

import XCTest

@testable import Future_Take_Home

class ArrayExtensionsTests: XCTestCase {
    
    var controller: WorkoutsController!
    
    override func setUp() async throws {
        controller = WorkoutsController(loadData: false)
        await controller.loadLocalData()
    }
    
    override func tearDown() {
        // Nothing to do here for now.
    }
    
    func testArrayExerciseSetSummary_VerifyMaxWeight() {
        let sut = controller.getSortedExercises().first!
        let max = sut.compactMap( { $0.weight } ).max()
        XCTAssertEqual(sut.maxWeight, Double(max!))
    }
    
    func testArrayExerciseSetSummary_VerifyTotalReps() {
        let sut = controller.getSortedExercises().first!
        let sum = sut.compactMap( { $0.repsCompleted } ).reduce(0, +)
        XCTAssertEqual(sut.totalReps, sum)
    }
    
    func testArrayExerciseSetSummary_VerifyExerciseName() {
        let sut = controller.getSortedExercises().first!
        XCTAssertEqual(sut.exerciseName, sut.first?.exerciseSet?.exercise?.name)
    }
    
    func testArrayWorkouts_VerifyCalories() {
        let sut = controller.workoutSummaries
        let sum = sut.compactMap( { $0.activeEnergyBurned }).reduce(0, +)
        XCTAssertEqual(sut.totalCaloriesBurned, sum)
    }
}
