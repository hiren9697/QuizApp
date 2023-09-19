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
    typealias Answer = String
    
    let navigationController: UINavigationController
    let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController,
         factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: QuestionType<String>,
                 answerCallback: @escaping (String) -> Void) {
        let questionVC = factory.questionViewController(for: question,
                                                        answerCallback: answerCallback)
        navigationController.pushViewController(questionVC, animated: true)
    }
    
    func routeTo(result: QuizeEngine.QuizResult<QuestionType<String>, String>) {
        let resultVC = factory.resultViewController(for: result)
        navigationController.pushViewController(resultVC, animated: true)
    }
}



//        let questionVC = Storyboards
//            .main
//            .instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
//                QuestionVC(question: question,
//                           options: [],
//                           coder: coder)
//            }

//        let resultVC = Storyboards
//            .main
//            .instantiateViewController(identifier: ResultVC.storyboardID) { coder in
//                ResultVC(summary: "Hello",
//                         answers: [],
//                         coder: coder)
//            }
