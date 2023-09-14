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
    func routeTo(result: [String: String])
}

class Flow {
    private let questions: [String]
    // This is intermediate result, used to store question and answer every time user answers a question
    private var result: [String: String] = [:]
    private let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: nextCallback(currentQuestion: firstQuestion))
        } else {
            router.routeTo(result: [:])
        }
    }
    
    private func nextCallback(currentQuestion: String)-> Router.AnswerCallback {
        return { answer in
            self.routeNext(question: currentQuestion, answer: answer)
        }
    }
    
    private func routeNext(question: String, answer: String) {
        result[question] = answer
        guard let currentQuestionIndex = questions.firstIndex(of: question) else {
            return
        }
        let nextQuestionIndex = currentQuestionIndex + 1
        if nextQuestionIndex < questions.count {
            // Route to next question
            let nextQuestion = questions[currentQuestionIndex + 1]
            self.router.routeTo(question: nextQuestion,
                                answerCallback: nextCallback(currentQuestion: nextQuestion))
        } else {
            // Route to result
            self.router.routeTo(result: result)
        }
    }
}
