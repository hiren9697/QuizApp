//
//  QuestionTypeTests.swift
//  QuizeEngineTests
//
//  Created by Hirenkumar Fadadu on 30/09/23.
//

import XCTest
@testable import QuizeEngine

final class QuestionTypeTests: XCTestCase {

    func test_equality_withSingleAnswer() {
        XCTAssertEqual(QuestionType.singleAnswer("first"), QuestionType.singleAnswer("first"))
        XCTAssertNotEqual(QuestionType.singleAnswer("first"), QuestionType.singleAnswer("second"))
        XCTAssertEqual(QuestionType.singleAnswer("first"), QuestionType.multiAnswer("first"))
        XCTAssertEqual(QuestionType.multiAnswer("first"), QuestionType.multiAnswer("first"))
        XCTAssertNotEqual(QuestionType.multiAnswer("first"), QuestionType.multiAnswer("second"))
    }
}
