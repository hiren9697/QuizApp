//
//  Flow.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 09/09/23.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String)-> Void
    func routeTo(question: String,
                 answerCallback: @escaping AnswerCallback)
}

class Flow {
    private let questions: [String]
    private let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: routeNext(currentQuestion: firstQuestion))
        }
    }
    
    private func routeNext(currentQuestion: String)-> Router.AnswerCallback {
        return { _ in
            guard let currentQuestionIndex = self.questions.firstIndex(of: currentQuestion) else {
                return
            }
            let nextQuestionIndex = currentQuestionIndex + 1
            if nextQuestionIndex < self.questions.count {
                let nextQuestion = self.questions[currentQuestionIndex + 1]
                self.router.routeTo(question: nextQuestion,
                                    answerCallback: self.routeNext(currentQuestion: nextQuestion))
            } else {
                // Route to result
            }
        }
    }
}
