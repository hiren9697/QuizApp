//
//  QuizResult.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation

struct QuizResult<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
