//
//  QuestionVCTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import XCTest
@testable import QuizeApp

final class QuestionVCTests: XCTestCase {

    
}

// MARK: - Helper method(s)
extension QuestionVCTests {
    
    private func makeSUT(question: String)-> QuestionVC {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(identifier: "QuestionVC") { coder in
            return QuestionVC(question: question, coder: coder)!
        }
    }
}
