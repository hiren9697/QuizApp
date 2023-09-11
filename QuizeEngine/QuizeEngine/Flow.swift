//
//  Flow.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 09/09/23.
//

import Foundation

protocol Router {
    func routeTo(question: String,
                 answerCallback: @escaping (String)-> Void)
}

class Flow {
    let questions: [String]
    let router: Router
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: getAnswerCallback(currentQuestion: firstQuestion))
        }
    }
    
    func getAnswerCallback(currentQuestion: String)-> (String)-> Void {
        return { _ in
            let currentQuestionIndex = self.questions.firstIndex(of: currentQuestion)!
            let nextQuestion = self.questions[currentQuestionIndex + 1]
            self.router.routeTo(question: nextQuestion,
                                answerCallback: self.getAnswerCallback(currentQuestion: nextQuestion))
        }
    }
}
