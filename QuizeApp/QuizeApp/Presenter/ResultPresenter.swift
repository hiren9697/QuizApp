//
//  ResultPresenter.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 23/09/23.
//

import Foundation
import QuizeEngine

struct ResultPresenter {
    let result: QuizResult<QuestionType<String>, [String]>
    let correctAnswers: [QuestionType<String>: [String]]
    let orderdQuestions: [QuestionType<String>]
    let summary: String
    let presentableAnswers: [PresentableAnswer]
    
    init(result: QuizResult<QuestionType<String>, [String]>,
         correctAnswers: [QuestionType<String>: [String]],
         orderedQuestions: [QuestionType<String>]) {
        self.result = result
        self.correctAnswers = correctAnswers
        self.orderdQuestions = orderedQuestions
        // Configure Presentable Answers
        var tempPresentableAnswer: [PresentableAnswer] = []
        for question in orderedQuestions {
            let userAnswer = result.answers[question]
            let correctAnswer = correctAnswers[question]
            let correctAnswerText = correctAnswer?.joined(separator: ", ") ?? ""
            let userAnswerText = userAnswer?.joined(separator: ", ") ?? ""
            if userAnswer == correctAnswer {
                // Given answer is correct
                tempPresentableAnswer.append(PresentableAnswer(question: question.value,
                                                               answer: userAnswerText))
            } else {
                // Given answer is incorrect
                tempPresentableAnswer.append(PresentableAnswer(question: question.value,
                                                               answer: correctAnswerText,
                                                              wrongAnswer: userAnswerText))
            }
        }
        // Assign presentable answers
        self.presentableAnswers = tempPresentableAnswer
        // Configure and assign summary
        self.summary = "You got \(result.score)/\(result.answers.count) correct"
    }
}
