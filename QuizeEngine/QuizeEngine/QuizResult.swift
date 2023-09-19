//
//  QuizResult.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation

public struct QuizResult<Question: Hashable, Answer: Hashable>: Hashable {
    public let answers: [Question: Answer]
    public let score: Int
}
