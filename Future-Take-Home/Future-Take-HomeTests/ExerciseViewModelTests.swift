//
//  ExerciseViewModelTests.swift
//  Future-Take-Home
//
//  Created by Mike Nuzzolo on 3/22/25.
//


import XCTest

@testable import Future_Take_Home

class ExerciseViewModelTests: XCTestCase {
    
    let controller = WorkoutsController()
    var sut: ExerciseViewModel!
    
    override func setUp() {
        sut = ExerciseViewModel(sets: controller.getSortedExercises().first!)
    }
    
    override func tearDown() {
        // Nothing to do here for now.
    }
    
    func testExerciseViewModel_VerifyInit() {
        XCTAssertNotNil(sut.sets)
    }
    
    func testExerciseViewModel_VerifyName() {
        XCTAssertEqual(sut.name, sut.sets.exerciseName)
    }
    
    func testExerciseViewModel_VerifyHand() {
        XCTAssertEqual(sut.hand, sut.sets.first?.exerciseSet?.exercise?.sideDisplayName)
    }
    
    // Verify the order of our sets (sorted by most recent date)
    func testExerciseViewModel_VerifySortedSetsOrder() {
        var lastSet: ExerciseSetSummary?
        for set in sut.sortedSets {
            if lastSet != nil {
                XCTAssertTrue(set.completedAt! < lastSet!.completedAt!)
                lastSet = set
            }
        }
    }
    
    // Verify the most recent sets call returns values from a single day
    func testExerciseViewModel_VerifyMostRecentSets() {
        XCTAssertTrue(sut.mostRecentSets.isNotEmpty)
        let date = sut.mostRecentSets.first!.completedAt!
        for set in sut.mostRecentSets {
            XCTAssertTrue( Calendar.current.isDate(set.completedAt!, inSameDayAs: date) )
        }
    }
    
    // Verify the least recent sets call returns values from a single day
    func testExerciseViewModel_VerifyLeastRecentSets() {
        XCTAssertTrue(sut.leastRecentSets.isNotEmpty)
        let date = sut.leastRecentSets.first!.completedAt!
        for set in sut.leastRecentSets {
            XCTAssertTrue( Calendar.current.isDate(set.completedAt!, inSameDayAs: date) )
        }
    }
    
    func testExerciseViewModel_VerifyWeightProgress() {
        let progress = (sut.mostRecentSets.maxWeight / sut.leastRecentSets.maxWeight) - 1
        XCTAssertEqual(progress, sut.weightProgress)
    }
    
    func testExerciseViewModel_VerifyRepProgress() {
        let progress = (Double(sut.mostRecentSets.totalReps) / Double(sut.leastRecentSets.totalReps)) - 1
        XCTAssertEqual(progress, sut.repsProgress)
    }
}
