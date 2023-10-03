//
//  QuestionPresenter.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 24/09/23.
//

import Foundation
import QuizeEngine

struct QuestionPresenter {
    let questions: [QuestionType<String>]
    let question: QuestionType<String>
    let title: String
    
    init(questions: [QuestionType<String>], question: QuestionType<String>) {
        self.questions = questions
        self.question = question
        if let index = questions.firstIndex(of: question) {
            title = "Question #\(index + 1)"
        } else {
            title = ""
        }
    }
}
