//
//  NavigationControllerRouter.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 17/09/23.
//

import UIKit
import QuizeEngine

class NavigationControllerRouter: Router {
    typealias Question = String
    typealias Answer = String
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(question: String,
                 answerCallback: @escaping (String) -> Void) {
        let questionVC = Storyboards
            .main
            .instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
                QuestionVC(question: question,
                           options: [],
                           coder: coder)
            }
        navigationController.pushViewController(questionVC, animated: false)
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
