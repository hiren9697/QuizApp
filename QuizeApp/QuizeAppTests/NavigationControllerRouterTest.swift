//
//  NavigationControllerRouterTest.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import XCTest
@testable import QuizeApp
@testable import QuizeEngine

final class NavigationControllerRouterTest: XCTestCase {
    let navigationController = NoAnimationNavigationController()
    let factory = ViewControllerFactoryStub()
    lazy var sut: NavigationControllerRouter = {
        NavigationControllerRouter(navigationController: self.navigationController,
                                   factory: self.factory)
    }()
    
    func test_routeToQuestion_presentsQuestionVC() {
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        factory.stub(question: QuestionType.singleAnswer("Q1"), with: firstVC)
        factory.stub(question: QuestionType.singleAnswer("Q2"), with: secondVC)
        sut.routeTo(question: QuestionType.singleAnswer("Q1"),
                    answerCallback: { _ in })
        sut.routeTo(question: QuestionType.singleAnswer("Q2"),
                    answerCallback: { _ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, firstVC)
        XCTAssertEqual(navigationController.viewControllers.last, secondVC)
    }

    func test_routeToQuestion_presentsQuestionVCWithRightCallback() {
        let firstVC = UIViewController()
        factory.stub(question: QuestionType.singleAnswer("Q1"), with: firstVC)
        var wasCallbackFired: Bool = false
        sut.routeTo(question: QuestionType.singleAnswer("Q1"),
                    answerCallback: { _ in
            wasCallbackFired = true
        })
        factory.answerCallbacks[QuestionType.singleAnswer("Q1")]!(["anything"])
        let submitButton = firstVC.navigationItem.rightBarButtonItem
        submitButton!.simulateTap()
        XCTAssertTrue(wasCallbackFired)
    }
    
    func test_submitButton_existsAndHaveCorrectConfiguration() {
        let firstVC = UIViewController()
        factory.stub(question: QuestionType.singleAnswer("Q1"), with: firstVC)
        sut.routeTo(question: QuestionType.singleAnswer("Q1"),
                    answerCallback: { _ in })
        let submitButton = firstVC.navigationItem.rightBarButtonItem
        XCTAssertNotNil(submitButton)
        XCTAssertNotNil(submitButton!.target!)
        XCTAssertNotNil(submitButton!.action!)
        XCTAssertEqual(submitButton?.title, "Submit")
    }
    
    func test_submitButton_updatesEnableState() {
        let firstVC = UIViewController()
        factory.stub(question: QuestionType.singleAnswer("Q1"), with: firstVC)
        sut.routeTo(question: QuestionType.singleAnswer("Q1"),
                    answerCallback: { _ in })
        let submitButton = firstVC.navigationItem.rightBarButtonItem!
        let callback = factory.answerCallbacks[QuestionType.singleAnswer("Q1")]!
        // 1. Check submit button is disabled by default
        XCTAssertFalse(submitButton.isEnabled)
        // 2. Select one answer & Check submit button becomes enable
        callback(["A1"])
        XCTAssertTrue(submitButton.isEnabled)
        // 3. Unselect all answers & Check submit button becomes disable
        callback([])
        XCTAssertFalse(submitButton.isEnabled)
        // 4. Select two answers & Check submit button becomes enable
        callback(["A1", "A2"])
        XCTAssertTrue(submitButton.isEnabled)
    }
    
    func test_routeToResult_presentsResultVC() {
        // Configure
        let firstVC = UIViewController()
        let secondVC = UIViewController()
        let firstResult = QuizResult(answers: [QuestionType.singleAnswer("Q1"): ["A1"]], score: 0)
        let secondResult = QuizResult(answers: [QuestionType.singleAnswer("Q2"): ["A2"]], score: 1)
        // Stub
        factory.stub(result: firstResult, with: firstVC)
        factory.stub(result: secondResult, with: secondVC)
        // Route to first result
        sut.routeTo(result: firstResult)
        // Test
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertEqual(navigationController.viewControllers.first, firstVC)
        // Route to second result
        sut.routeTo(result: secondResult)
        // Test
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.last, secondVC)
    }
}

