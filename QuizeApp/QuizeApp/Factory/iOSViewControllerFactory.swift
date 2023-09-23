//
//  iOSViewControllerFactory.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 20/09/23.
//

import UIKit
import QuizeEngine

class iOSViewControllerFactory: ViewControllerFactory {
    let options: Dictionary<QuestionType<String>, [String]>
    
    init(options: Dictionary<QuestionType<String>, [String]>) {
        self.options = options
    }
    
    func questionViewController(for question: QuestionType<String>,
                                answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        let questionText: String
        switch question {
        case .singleAnswer(let questionTextValue): questionText = questionTextValue
        case .multiAnswer(let questionTextValue): questionText = questionTextValue
        }
        return Storyboards.main.instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
            QuestionVC(question: questionText,
                       options: self.options[question]!,
                       selection: answerCallback,
                       coder: coder) ?? UIViewController()
        }
    }
    
    func resultViewController(for result: QuizeEngine.QuizResult<QuestionType<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
