//
//  QuestionTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import XCTest
@testable import QuizeApp

final class QuestionTests: XCTestCase {

//    func test_hashValue_singleAnswer_returnsHashType() {
//        let type = "a single answer"
//        let sut = Question.singleAnswer(type)
//        XCTAssertEqual(type.hashValue, sut.hashValue)
//    }
    
    func test_equality_withSingleAnswer() {
        XCTAssertEqual(Question.singleAnswer("first"), Question.singleAnswer("first"))
        XCTAssertNotEqual(Question.singleAnswer("first"), Question.singleAnswer("second"))
        XCTAssertEqual(Question.singleAnswer("first"), Question.multiAnswer("first"))
        XCTAssertEqual(Question.multiAnswer("first"), Question.multiAnswer("first"))
        XCTAssertNotEqual(Question.multiAnswer("first"), Question.multiAnswer("second"))
    }
}
