//
//  SceneDelegate.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 14/09/23.
//

import UIKit
import QuizeEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        startApp(windowScene: windowScene)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

// MARK: - Helper method(s)
extension SceneDelegate {
    
    private func startApp(windowScene: UIWindowScene) {
        // 1. Questions
        let firstQuestion = QuestionType.multiAnswer("Who are indians?")
        let option1_1 = "A.P.J. Abdul Kalam"
        let option1_2 = "Rajiv Gandhi"
        let option1_3 = "Mohammad Jina"
        let secondQuestion = QuestionType.singleAnswer("What is capital of india?")
        let option2_1 = "Delhi"
        let option2_2 = "Jaipur"
        let option2_3 = "Mumbai"
        let option2_4 = "Bangaluru"
        /// 1.1 All questions
        let allQuestions = [firstQuestion, secondQuestion]
        /// 1.2 Questions with options
        lazy var questionsWithOptions: Dictionary<QuestionType<String>, [String]> = {
            return [
                firstQuestion: [option1_1, option1_2, option1_3],
                secondQuestion: [option2_1, option2_2, option2_3, option2_4]
            ]
        }()
        /// 1.3 Correct answers
        lazy var correctAnswers: Dictionary<QuestionType<String>, [String]> = {
            return [
                firstQuestion: [option1_1, option1_2],
                secondQuestion: [option2_1]
            ]
        }()
        
        // 2. Router
        /// 2.1 NavigationController
        let navigationController = UINavigationController()
        /// 2.2 Factory
        let factory = iOSViewControllerFactory(questions: allQuestions,
                                               options: questionsWithOptions,
                                               correctAnswers: correctAnswers)
        /// 2.3 Router
        let router = NavigationControllerRouter(navigationController: navigationController,
                                                factory: factory)
        
        // 3. Start game
        App.delegate.game = startGame(questions: allQuestions,
                                      router: router,
                                      correctAnswers: correctAnswers)
        
        // 4. Configure window
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}
