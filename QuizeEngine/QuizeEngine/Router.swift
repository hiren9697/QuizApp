//
//  Router.swift
//  QuizeEngine
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    func routeTo(question: Question,
                 answerCallback: @escaping (Answer)-> Void)
    func routeTo(result: QuizResult<Question, Answer>)
}
