//
//  FlowTest.swift
//  QuizeEngineTests
//
//  Created by Hirenkumar Fadadu on 09/09/23.
//

import XCTest
@testable import QuizeEngine

final class FlowTest: XCTestCase {
    let router = RouterSpy()

    func test_startWithNoQuestion_doesNotRouteToQuestion() {
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_startWithOneQuestion_routesToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }

    func test_startWithOneQuestion_routesToCorrectQuestion_2() {
        let sut = makeSUT(questions: ["Q2"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }

    func test_startWithTwoQuestions_routesToCorrectQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwiceWithTwoQuestions_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startWithThreeQuestions_answerFirstAndSecondQuestion_routesToThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startWithOneQuestions_answerFirstQuestion_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startWithNoQuestion_routesToResult() {
        let sut = makeSUT(questions: [])
        sut.start()
        XCTAssertEqual(router.routedResult, [:])
    }
    
    func test_startWithOneQuestions_answerFirstQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResult, ["Q1": "A1"])
    }
    
    func test_startWithTwoQuestions_answerFirstQuestion_doesNotRouteToResult_AndAnswerSecondQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    func makeSUT(questions: [String])-> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: [String: String]?
        var answerCallback: Router.AnswerCallback = { _ in }
        
        func routeTo(question: String,
                     answerCallback: @escaping Router.AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String: String]) {
            routedResult = result
        }
    }
}
