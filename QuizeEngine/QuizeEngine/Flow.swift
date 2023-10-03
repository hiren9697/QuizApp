//
//  Flow.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 09/09/23.
//

import Foundation

class Flow<Question: Hashable,
           Answer: Hashable,
           R: Router> where R.Question == Question,
                            R.Answer == Answer {
    private let questions: [Question]
    // This is intermediate result, used to store question and answer every time user answers a question
    private var answers: [Question: Answer] = [:]
    private let router: R
    private let scoring: ([Question: Answer])-> Int
    
    init(questions: [Question],
         router: R,
         scoring: @escaping ([Question: Answer])-> Int) {
        self.questions = questions
        self.router = router
        self.scoring = scoring
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion,
                           answerCallback: nextCallback(currentQuestion: firstQuestion))
        } else {
            router.routeTo(result: result())
        }
    }
    
    private func nextCallback(currentQuestion: Question)-> (Answer)-> Void {
        return {[weak self] answer in
            self?.routeNext(question: currentQuestion, answer: answer)
        }
    }
    
    private func routeNext(question: Question, answer: Answer) {
        answers[question] = answer
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
            self.router.routeTo(result: result())
        }
    }
    
    private func result()-> QuizResult<Question, Answer> {
        QuizResult(answers: answers, score: scoring(answers))
    }
}
