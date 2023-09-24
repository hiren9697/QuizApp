//
//  PresentableAnswer.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import Foundation

struct PresentableAnswer: Equatable {
    let question: String
    let answer: String
    let wrongAnswer: String?
    
    var isCorrect: Bool {
        wrongAnswer == nil
    }
    
    init(question: String,
         answer: String,
         wrongAnswer: String? = nil) {
        self.question = question
        self.answer = answer
        self.wrongAnswer = wrongAnswer
    }
}
