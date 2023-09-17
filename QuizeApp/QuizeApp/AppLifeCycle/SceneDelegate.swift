//
//  SceneDelegate.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 14/09/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 1. Init initial view controller
        let vc = getDummyResultVC()
        // 2. Configure window
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = vc
        self.window = window
        window.makeKeyAndVisible()
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
    
    func getDummyQuestionVC() {
        let questionVC = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
                QuestionVC(question: "Q1",
                           options: ["O1", "O2", "O3"],
                           coder: coder)!
            }
        let navigationVC = UINavigationController(rootViewController: questionVC)
    }
    
    func getDummyResultVC()-> UIViewController {
        let resultVC = UIStoryboard(name: "Main", bundle: Bundle.main)
            .instantiateViewController(identifier: ResultVC.storyboardID) { coder in
                ResultVC(summary: "Got 2 questions correct out of 4 questions",
                         answers: [
                            PresentableAnswer(question: "Q1",
                                              answer: "A1"),
                            PresentableAnswer(question: "Q2",
                                              answer: "A1",
                                              wrongAnswer: "A2"),
                            PresentableAnswer(question: "Q3",
                                              answer: "A2",
                                              wrongAnswer: "A1"),
                            PresentableAnswer(question: "Q4",
                                              answer: "A2"),
                         ],
                         coder: coder)
            }
        let navigationVC = UINavigationController(rootViewController: resultVC)
        return navigationVC
    }
}

