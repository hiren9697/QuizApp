//
//  ResultVCTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import XCTest
@testable import QuizeApp

final class ResultVCTests: XCTestCase {
    func test_viewDidLoad_rendersTitle() {
        XCTAssertEqual(makeSUT().title, "Result")
    }
    
    func test_viewDidLoad_rendersSummary() {
        let summary = "Got 3 of 5 questions"
        XCTAssertEqual(makeSUT(summary: summary).lblHeader.text!, summary)
    }
    
    func test_withoutAnswers_doesNotRenderAnswers() {
        XCTAssertEqual(makeSUT(answers: []).tableView.numberOfRows(inSection: 0),
                       0)
    }
    
    func test_withOneCorrectAnswer_rendersCorrectAnswer() {
        let question = "Q1"
        let answer = "A1"
        let sut = makeSUT(answers: [
            PresentableAnswer(question: question, answer: answer)
        ])
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ResultCorrectAnswerTC
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.lblQuestion.text, question)
        XCTAssertEqual(cell?.lblAnswer.text, answer)
    }
    
    func test_withOneWrongAnswer_rendersWrongAnswer() {
        let question = "Q1"
        let answer = "A1"
        let wrongAnswer = "A2"
        let sut = makeSUT(answers: [
            PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
        ])
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ResultWrongAnswerTC
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.lblQuestion.text, question)
        XCTAssertEqual(cell?.lblAnswer.text, answer)
        XCTAssertEqual(cell?.lblWrongAnswer.text, wrongAnswer)
    }
}

extension ResultVCTests {
    private func makeSUT(summary: String = "",
                         answers: [PresentableAnswer] = [])-> ResultVC {
        let resultVC = Storyboards
            .main
            .instantiateViewController(identifier: ResultVC.storyboardID) { coder in
                ResultVC(title: "Result",
                         summary: summary,
                         answers: answers,
                         coder: coder)
            }
        _ = resultVC.view
        return resultVC
    }
}
