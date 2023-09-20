//
//  ViewControllerFactoryStub.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 19/09/23.
//

import UIKit
@testable import QuizeEngine
@testable import QuizeApp

class ViewControllerFactoryStub: ViewControllerFactory {
    var stubedQuestions: [QuestionType<String>: UIViewController] = [:]
    var stubedResults: Dictionary<QuizResult<QuestionType<String>, String>, UIViewController> = [:]
    var answerCallbacks: [QuestionType<String>: (String)-> Void] = [:]
    
    // Stub methods
    func stub(question: QuestionType<String>,
              with viewController: UIViewController) {
        stubedQuestions[question] = viewController
    }
    func stub(result: QuizResult<QuestionType<String>, String>,
              with viewController: UIViewController) {
        stubedResults[result] = viewController
    }
    // Factory methods
    func questionViewController(for question: QuestionType<String>,
                                answerCallback: @escaping (String) -> Void) -> UIViewController {
        answerCallbacks[question] = answerCallback
        return stubedQuestions[question]!
    }
    func resultViewController(for result: QuizResult<QuestionType<String>, String>) -> UIViewController {
        return stubedResults[result]!
    }
}
