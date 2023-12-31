//
//  NavigationControllerRouter.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import UIKit
import QuizeEngine

class NavigationControllerRouter: Router {
    typealias Question = QuestionType<String>
    typealias Answer = [String]
    
    let navigationController: UINavigationController
    let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController,
         factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: QuestionType<String>,
                 answerCallback: @escaping ([String]) -> Void) {
        // 1. Configure submit button
        let submitButton = UIBarButtonItem(title: "Submit",
                                           style: .done,
                                           target: nil,
                                           action: nil)
        submitButton.isEnabled = false
        let buttonController = SubmitButtonController(answerCallback: answerCallback,
                                                      button: submitButton)
        // 2. Configure ViewController
        let questionVC = factory.questionViewController(for: question,
                                                        answerCallback: {[weak self] selection in
            guard let _ = self else { return }
            buttonController.update(selection)
        })
        questionVC.navigationItem.rightBarButtonItem = submitButton
        navigationController.pushViewController(questionVC, animated: true)
    }
    
    func routeTo(result: QuizeEngine.QuizResult<QuestionType<String>, [String]>) {
        let resultVC = factory.resultViewController(for: result)
        navigationController.pushViewController(resultVC, animated: true)
    }
}
