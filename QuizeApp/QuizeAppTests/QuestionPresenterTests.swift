//
//  QuestionPresenterTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 24/09/23.
//

import XCTest
import QuizeEngine
@testable import QuizeApp

final class QuestionPresenterTests: XCTestCase {
    let firstSingleAnswerQuestion = QuestionType.singleAnswer("Q1")
    let firstMultipleAnswerQuestion = QuestionType.multiAnswer("Q2")

    func test_title_withEmptyQuestions() {
        let sut = makeSUT(questions: [],
                          question: firstSingleAnswerQuestion)
        XCTAssertEqual(sut.title, "")
    }
    
    func test_title_ofFirstQuestion_withTwoQuestions() {
        let sut = makeSUT(questions: [firstSingleAnswerQuestion,
                                     firstMultipleAnswerQuestion],
                          question: firstSingleAnswerQuestion)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_ofSecondQuestion_withTwoQuestions() {
        let sut = makeSUT(questions: [firstSingleAnswerQuestion,
                                     firstMultipleAnswerQuestion],
                          question: firstMultipleAnswerQuestion)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    // MARK: - Helper
    func makeSUT(questions: [QuestionType<String>],
                 question :QuestionType<String>)-> QuestionPresenter {
        return QuestionPresenter(questions: questions,
                                 question: question)
    }
}
