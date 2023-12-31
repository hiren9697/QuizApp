//
//  iOSViewControllerFactory.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 20/09/23.
//

import UIKit
import QuizeEngine

class iOSViewControllerFactory: ViewControllerFactory {
    let questions: [QuestionType<String>]
    let options: Dictionary<QuestionType<String>, [String]>
    let correctAnswers: Dictionary<QuestionType<String>, [String]>
    
    init(questions: [QuestionType<String>],
         options: Dictionary<QuestionType<String>, [String]>,
         correctAnswers: Dictionary<QuestionType<String>, [String]>) {
        self.questions = questions
        self.options = options
        self.correctAnswers = correctAnswers
    }
    
    func questionViewController(for question: QuestionType<String>,
                                answerCallback: @escaping ([String]) -> Void) -> UIViewController {
        guard let questionOptions = options[question] else {
            fatalError("Couldn't find options for question: \(question)")
        }
        // Question Presenter
        let questionPresenter = QuestionPresenter(questions: questions,
                                                  question: question)
        switch question {
        case .singleAnswer(let questionTextValue):
            let vc = instantiateQuestionVC(title: questionPresenter.title,
                                           questionText: questionTextValue,
                                           options: questionOptions,
                                           allowMultipleSelection: false,
                                           selection: answerCallback)
            return vc
        case .multiAnswer(let questionTextValue):
            let vc = instantiateQuestionVC(title: questionPresenter.title,
                                           questionText: questionTextValue,
                                           options: questionOptions,
                                           allowMultipleSelection: true,
                                           selection: answerCallback)
            return vc
        }
    }
    
    func instantiateQuestionVC(title: String,
                               questionText: String,
                               options: [String],
                               allowMultipleSelection: Bool,
                               selection: @escaping ([String])-> Void)-> QuestionVC {
        // Initialize ViewController
        let vc = Storyboards.main.instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
            let vc = QuestionVC(title: title,
                                question: questionText,
                                options: options,
                                allowMultipleSelection: allowMultipleSelection,
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
        //_ = questionVC.view
        return questionVC
    }
    
    func resultViewController(for result: QuizeEngine.QuizResult<QuestionType<String>, [String]>) -> UIViewController {
        let presenter = ResultPresenter(result: result,
                                        correctAnswers: correctAnswers,
                                        orderedQuestions: questions)
        // Initialize ViewController
        let vc = Storyboards.main.instantiateViewController(identifier: ResultVC.storyboardID) { coder in
            let vc = ResultVC(title: presenter.title,
                              summary: presenter.summary,
                              answers: presenter.presentableAnswers,
                              coder: coder)
            guard let vc = vc else {
                fatalError("Couldn't instantiate QuestionVC for result: \(result)")
            }
            return vc
        }
        // Downcast UIViewController to ResultVC
        guard let resultVC = vc as? ResultVC else {
            fatalError("Initiated view controller is not QuestionVC")
        }
        // Cinfigure QuestionVC
        //_ = questionVC.view
        return resultVC
    }
}
