//
//  NavigationControllerRouterTest.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import XCTest
@testable import QuizeApp

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
        factory.stub(question: "Q1", with: firstVC)
        factory.stub(question: "Q2", with: secondVC)
        sut.routeTo(question: "Q1",
                    answerCallback: { _ in })
        sut.routeTo(question: "Q2",
                    answerCallback: { _ in })
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, firstVC)
        XCTAssertEqual(navigationController.viewControllers.last, secondVC)
    }
    
    func test_routeToQuestion_presentsQuestionVCWithRightCallback() {
        let firstVC = UIViewController()
        factory.stub(question: "Q1", with: firstVC)
        var wasCallbackFired: Bool = false
        sut.routeTo(question: "Q1",
                    answerCallback: { _ in
            wasCallbackFired = true
        })
        factory.answerCallbacks["Q1"]!("anything")
        XCTAssertTrue(wasCallbackFired)
    }
    
    // MARK: - Helper
    class ViewControllerFactoryStub: ViewControllerFactory {
        var stubedQuestions: [String: UIViewController] = [:]
        var answerCallbacks: [String: (String)-> Void] = [:]
        
        func stub(question: String, with viewController: UIViewController) {
            stubedQuestions[question] = viewController
        }
        
        func questionViewController(for question: String,
                                    answerCallback: @escaping (String) -> Void) -> UIViewController {
            answerCallbacks[question] = answerCallback
            return stubedQuestions[question]!
        }
    }
    
    class NoAnimationNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
}
