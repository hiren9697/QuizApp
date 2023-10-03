//
//  iOSViewControllerFactoryTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 20/09/23.
//

import XCTest
@testable import QuizeEngine
@testable import QuizeApp

final class iOSViewControllerFactoryTests: XCTestCase {
    let firstQuestion = QuestionType.singleAnswer("Q1")
    let secondQuestion = QuestionType.multiAnswer("Q2")
    let firstQuestionOptions = ["A1", "A2"]
    let secondQuestionOptions = ["A1", "A2"]
    let firstQuestionAnswer = ["A1"]
    let secondQuestionAnswer = ["A1", "A2"]
    lazy var questions: [QuestionType] = {
        return [firstQuestion, secondQuestion]
    }()
    lazy var options: [QuestionType: [String]] = {
        return [
            firstQuestion: firstQuestionOptions,
            secondQuestion: secondQuestionOptions
        ]
    }()
    lazy var correctAnswers: [QuestionType: [String]] = {
       return [
        firstQuestion: firstQuestionAnswer,
        secondQuestion: secondQuestionAnswer
       ]
    }()
    lazy var orderedQuestions: [QuestionType] = {
        return [firstQuestion, secondQuestion]
    }()
    
    func test_title() {
        let sut = makeSUT(questions: questions,
                          options: options,
                          correctAnswers: correctAnswers)
        let firstQuestionVC = sut.questionViewController(for: firstQuestion,
                                                    answerCallback: { _ in })
        XCTAssertEqual(firstQuestionVC.title, "Question #1")
        let secondQuestionVC = sut.questionViewController(for: secondQuestion,
                                                          answerCallback: { _ in })
        XCTAssertEqual(secondQuestionVC.title, "Question #2")
    }
    
    func test_questionVCConfiguration_withSingleAnswerQuestion() {
        // Configure
        let sut = makeSUT(questions: questions,
                          options: options,
                          correctAnswers: correctAnswers)
        let controller = sut.questionViewController(for: firstQuestion, answerCallback: { _ in }) as? QuestionVC
        // Test
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, firstQuestion.value)
        XCTAssertEqual(controller?.options, firstQuestionOptions)
        XCTAssertEqual(controller?.allowMultipleSelection, false)
    }
    
    func test_questionVCConfiguration_withMultiAnswerQuestion() {
        // Configure
        let sut = makeSUT(questions: [secondQuestion],
                          options: [secondQuestion: secondQuestionOptions],
                          correctAnswers: [secondQuestion: secondQuestionAnswer])
        let controller = sut.questionViewController(for: secondQuestion, answerCallback: { _ in }) as? QuestionVC
        // Test
        XCTAssertNotNil(controller)
        XCTAssertEqual(controller?.question, secondQuestion.value)
        XCTAssertEqual(controller?.options, secondQuestionOptions)
        XCTAssertEqual(controller?.allowMultipleSelection, true)
    }
    
    func test_resultVCConfiguration() {
        // Configure
        let userAnswers = [firstQuestion: ["A1"],
                          secondQuestion: ["A2"]]
        let result = QuizResult(answers: userAnswers, score: 1)
        let resultPresenter = ResultPresenter(result: result,
                                              correctAnswers: correctAnswers,
                                              orderedQuestions: orderedQuestions)
        let sut = makeSUT(questions: questions,
                          options: options,
                          correctAnswers: correctAnswers)
        let resultVC = sut.resultViewController(for: result) as! ResultVC
        
        // Test
        XCTAssertEqual(resultVC.title, resultPresenter.title)
        XCTAssertEqual(resultVC.summary, resultPresenter.summary)
        XCTAssertEqual(resultVC.answers, resultPresenter.presentableAnswers)
    }
    
    // MARK: - Helper method(s)
    func makeSUT(questions: [QuestionType<String>],
                 options: Dictionary<QuestionType<String>, [String]>,
                 correctAnswers: Dictionary<QuestionType<String>, [String]>)-> iOSViewControllerFactory {
        return iOSViewControllerFactory(questions: questions,
                                        options: options,
                                        correctAnswers: correctAnswers)
    }
}
