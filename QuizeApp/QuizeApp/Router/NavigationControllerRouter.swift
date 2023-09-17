//
//  NavigationControllerRouter.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import UIKit
import QuizeEngine

protocol ViewControllerFactory {
    func questionViewController(for question: String,
                                answerCallback: @escaping (String)-> Void)-> UIViewController
}

class NavigationControllerRouter: Router {
    typealias Question = String
    typealias Answer = String
    
    let navigationController: UINavigationController
    let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController,
         factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: String,
                 answerCallback: @escaping (String) -> Void) {
//        let questionVC = Storyboards
//            .main
//            .instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
//                QuestionVC(question: question,
//                           options: [],
//                           coder: coder)
//            }
        let questionVC = factory.questionViewController(for: question,
                                                        answerCallback: answerCallback)
        navigationController.pushViewController(questionVC, animated: true)
    }
    
    func routeTo(result: QuizeEngine.QuizResult<String, String>) {
        let resultVC = Storyboards
            .main
            .instantiateViewController(identifier: ResultVC.storyboardID) { coder in
                ResultVC(summary: "Hello",
                         answers: [],
                         coder: coder)
            }
    }
}
