//
//  ViewControllerFactory.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 19/09/23.
//

import UIKit
import QuizeEngine

protocol ViewControllerFactory {
    func questionViewController(for question: QuestionType<String>,
                                answerCallback: @escaping (String)-> Void)-> UIViewController
    func resultViewController(for result: QuizResult<QuestionType<String>, String>)-> UIViewController
}
