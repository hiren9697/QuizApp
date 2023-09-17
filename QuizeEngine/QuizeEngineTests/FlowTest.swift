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
        XCTAssertEqual(router.routedResult?.answers, [:])
    }
    
    func test_startWithOneQuestions_answerFirstQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResult?.answers, ["Q1": "A1"])
    }
    
    func test_startWithTwoQuestions_answerFirstQuestion_doesNotRouteToResult_AndAnswerSecondQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult?.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    /// Test statically passed score to scoring closure
    func test_startWithTwoQuestions_answerFirstAndSecondQuestion_scores() {
        let sut = makeSUT(questions: ["Q1", "Q2"], scoring: { _ in 10 })
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResult?.score, 10)
    }
    
    /// Test Flow object passes right answers to scoring closure
    func test_startWithTwoQuestions_answerFirstAndSecondQuestion_scoresWithRightAnswers() {
        var receivedAnswers: [String: String]?
        let sut = makeSUT(questions: ["Q1", "Q2"],
                          scoring: { answers in
            receivedAnswers = answers
            return 0
        })
        sut.start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResult)
        router.answerCallback("A2")
        XCTAssertEqual(receivedAnswers, ["Q1": "A1", "Q2": "A2"])
    }
    
    // MARK: - Helper
    func makeSUT(questions: [String],
                 scoring: @escaping ([String: String])-> Int = { _ in 0 })-> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router, scoring: scoring)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: QuizResult<String, String>?
        var answerCallback: (String)-> Void = { _ in }
        
        func routeTo(question: String,
                     answerCallback: @escaping (String)-> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: QuizResult<String, String>) {
            routedResult = result
        }
    }
}
