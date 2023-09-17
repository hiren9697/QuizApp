//
//  Flow.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 09/09/23.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question,
                 answerCallback: @escaping (Answer)-> Void)
    func routeTo(result: [Question: Answer])
}

class Flow<Question: Hashable,
           Answer,
           R: Router> where R.Question == Question,
                            R.Answer == Answer {
    private let questions: [Question]
    // This is intermediate result, used to store question and answer every time user answers a question
    private var result: [Question: Answer] = [:]
    private let router: R
    
    init(questions: [Question], router: R) {
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
    
    private func nextCallback(currentQuestion: Question)-> (Answer)-> Void {
        return { answer in
            self.routeNext(question: currentQuestion, answer: answer)
        }
    }
    
    private func routeNext(question: Question, answer: Answer) {
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
