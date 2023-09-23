//
//  iOSViewControllerFactoryTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 20/09/23.
//

import XCTest
import QuizeEngine
@testable import QuizeApp

final class iOSViewControllerFactoryTests: XCTestCase {
    
    func test_questionVCWithSingleAnswerQuestion_createsController_withQuestionOptionsAndSingleSelection() {
        // Configure
        let question = QuestionType.singleAnswer("Q1")
        let questionOptions = ["O1", "O2"]
        let options = [question: questionOptions]
        let sut = makeSUT(options: options)
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionVC
        // Test
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
        XCTAssertEqual(controller?.options, questionOptions)
        XCTAssertEqual(controller?.tableView.allowsMultipleSelection, false)
    }
    
    func test_questionVCWithMultiAnswerQuestion_createsController_withQuestionOptionsAndMultipleSelection() {
        // Configure
        let question = QuestionType.multiAnswer("Q1")
        let questionOptions = ["O1", "O2"]
        let options = [question: questionOptions]
        let sut = makeSUT(options: options)
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionVC
        // Test
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
        XCTAssertEqual(controller?.options, questionOptions)
        XCTAssertEqual(controller?.tableView.allowsMultipleSelection, true)
    }
    
    // MARK: - Helper method(s)
    func makeSUT(options: Dictionary<QuestionType<String>, [String]>)-> iOSViewControllerFactory {
        return iOSViewControllerFactory(options: options)
    }
}
