//
//  Future_Take_HomeTests.swift
//  Future-Take-HomeTests
//
//  Created by Mike Nuzzolo on 3/21/25.
//

import Testing
import XCTest

@testable import Future_Take_Home

struct Future_Take_HomeTests {

    @Test func example() async throws {
        let controller = WorkoutsController()
        #expect(controller.workoutSummaries.isNotEmpty)
    }

}
