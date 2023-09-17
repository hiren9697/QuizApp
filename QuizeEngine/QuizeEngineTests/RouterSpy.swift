//
//  RouterSpy.swift
//  QuizeEngineTests
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation
@testable import QuizeEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: QuizResult<String, String>?
    var answerCallback: (String)-> Void = { _ in }
    
    func routeTo(question: String,
                 answerCallback: @escaping (String)-> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: QuizResult<String, String>) {
        routedResult = result
    }
}
