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
        guard let questionOptions = options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        switch question {
        case .singleAnswer(let questionTextValue):
            let vc = instantiateQuestionVC(questionText: questionTextValue,
                                           options: questionOptions,
                                           allowMultipleSelection: false,
                                           selection: answerCallback)
            return vc
        case .multiAnswer(let questionTextValue):
            let vc = instantiateQuestionVC(questionText: questionTextValue,
                                           options: questionOptions,
                                           allowMultipleSelection: true,
                                           selection: answerCallback)
            return vc
        }
    }
    
    func instantiateQuestionVC(questionText: String,
                               options: [String],
                               allowMultipleSelection: Bool,
                               selection: @escaping ([String])-> Void)-> QuestionVC {
        // Initialize ViewController
        let vc = Storyboards.main.instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
            let vc = QuestionVC(question: questionText,
                                options: options,
                                selection: selection,
                                coder: coder)
            guard let vc = vc else {
                fatalError("Couldn't instantiate QuestionVC for questionText: \(questionText), options: \(options), allowMultipleSelection: \(allowMultipleSelection), selection: \(String(describing: selection))")
            }
            return vc
        }
        // Downcast UIViewController to QuestionVC
        guard let questionVC = vc as? QuestionVC else {
            fatalError("Initiated view controller is not QuestionVC")
        }
        // Cinfigure QuestionVC
        _ = questionVC.view
        questionVC.tableView.allowsMultipleSelection = allowMultipleSelection
        return questionVC
    }
    
    func resultViewController(for result: QuizeEngine.QuizResult<QuestionType<String>, [String]>) -> UIViewController {
        UIViewController()
    }
}
