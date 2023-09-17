//
//  GameTest.swift
//  QuizeEngineTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import XCTest
import QuizeEngine

final class GameTest: XCTestCase {
    var game: Game<String, String, RouterSpy>?
    var router: RouterSpy?

    func test_startGame_answerOneOutOfTwoQuestionsCorrectly_scores_One() {
        router = RouterSpy()
        game = startGame(questions: ["Q1", "Q2"],
                  router: router!,
                  correctAnswers: ["Q1": "A1", "Q2": "A2"])
        router?.answerCallback("A1")
        router?.answerCallback("wrong")
        XCTAssertEqual(router?.routedResult?.score, 1)
    }
    
    func test_startGame_answerZeroOutOfTwoQuestionsCorrectly_scores_Zero() {
        router = RouterSpy()
        game = startGame(questions: ["Q1", "Q2"],
                  router: router!,
                  correctAnswers: ["Q1": "A1", "Q2": "A2"])
        router?.answerCallback("wrong")
        router?.answerCallback("wrong")
        XCTAssertEqual(router?.routedResult?.score, 0)
    }
    
    func test_startGame_answerTwoOutOfTwoQuestionsCorrectly_scores_Two() {
        router = RouterSpy()
        game = startGame(questions: ["Q1", "Q2"],
                  router: router!,
                  correctAnswers: ["Q1": "A1", "Q2": "A2"])
        router?.answerCallback("A1")
        router?.answerCallback("A2")
        XCTAssertEqual(router?.routedResult?.score, 2)
    }
}
