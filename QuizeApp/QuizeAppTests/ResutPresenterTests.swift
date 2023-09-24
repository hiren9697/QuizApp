//
//  ResutPresenterTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 23/09/23.
//

import XCTest
@testable import QuizeEngine
@testable import QuizeApp

final class ResultPresenterTests: XCTestCase {
    let firstSingleAnsweQuestion = QuestionType.singleAnswer("Q1")
    let secondSingleAnsweQuestion = QuestionType.singleAnswer("Q2")
    let firstMultipleAnsweQuestion = QuestionType.multiAnswer("Q3")
    let secondMultipleAnsweQuestion = QuestionType.multiAnswer("Q4")
    
    func test_summary_withZeroQuestion() {
        let sut = makeSUT(result: QuizResult(answers: [:],
                                             score: 0),
                          correctAnswers: [:],
                          orderedQuestions: [])
        XCTAssertEqual(sut.summary, "You got 0/0 correct")
    }
    
    func test_summary_withTwoQuestionAndOneScore() {
        let sut = makeSUT(result: QuizResult(answers: [firstSingleAnsweQuestion: ["A1"],
                                                       firstMultipleAnsweQuestion: ["A2"]],
                                             score: 1),
                          correctAnswers: [firstSingleAnsweQuestion: ["A1"],
                                           firstMultipleAnsweQuestion: ["A1"]],
                          orderedQuestions: [firstSingleAnsweQuestion,
                                             firstMultipleAnsweQuestion])
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withZeroQuestions() {
        let sut = makeSUT(result: QuizResult(answers: [:],
                                             score: 0),
                          correctAnswers: [:],
                          orderedQuestions: [])
        XCTAssertTrue(sut.presentableAnswers.isEmpty)
    }
    
    func test_presentableAnswers_withTwoQuestionOneCorrectOneIncorrect() {
        let sut = makeSUT(result: QuizResult(answers: [secondMultipleAnsweQuestion: ["A1"],
                                                       secondSingleAnsweQuestion: ["A2"]],
                                             score: 1),
                          correctAnswers: [secondMultipleAnsweQuestion: ["A1"],
                                           secondSingleAnsweQuestion: ["A1"]],
                          orderedQuestions: [secondMultipleAnsweQuestion,
                                             secondSingleAnsweQuestion])
        XCTAssertEqual(sut.presentableAnswers,
                       [PresentableAnswer(question: "Q4", answer: "A1"),
                       PresentableAnswer(question: "Q2", answer: "A1", wrongAnswer: "A2")])
    }

    
    // MARK: - Helpers
    func makeSUT(result: QuizResult<QuestionType<String>, [String]>,
                 correctAnswers: [QuestionType<String>: [String]],
                 orderedQuestions: [QuestionType<String>])-> ResultPresenter {
        return ResultPresenter(result: result,
                               correctAnswers: correctAnswers,
                               orderedQuestions: orderedQuestions)
    }
}
