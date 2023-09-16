//
//  ResultVCTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import XCTest
@testable import QuizeApp

final class ResultVCTests: XCTestCase {
    func test_viewDidLoad_rendersSummary() {
        let summary = "Got 3 of 5 questions"
        XCTAssertEqual(makeSUT(summary: summary).lblHeader.text!, summary)
    }
    
    func test_withoutAnswers_doesNotRenderAnswers() {
        let sut = makeSUT(summary: "")
    }
}

extension ResultVCTests {
    private func makeSUT(summary: String)-> ResultVC {
        let resultVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "ResultVC") { coder in
            ResultVC(summary: summary, coder: coder)
        }
        _ = resultVC.view
        return resultVC
    }
}
