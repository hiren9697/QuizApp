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
    
    func test_questionViewController_createsController_withQuestionAndOptions() {
        let question = QuestionType.singleAnswer("Q1")
        let options = ["O1", "O2"]
        let sut = iOSViewControllerFactory(options: [question: options])
        let controller = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionVC
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, "Q1")
        XCTAssertEqual(controller?.options, options)
    }
}
