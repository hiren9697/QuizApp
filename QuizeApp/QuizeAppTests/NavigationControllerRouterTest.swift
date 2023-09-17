//
//  NavigationControllerRouterTest.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import XCTest
@testable import QuizeApp

final class NavigationControllerRouterTest: XCTestCase {
    func test_routeToQuestion_presentsQuestionVC() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController: navigationController)
        sut.routeTo(question: "Q1",
                    answerCallback: { _ in })
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
}
