//
//  ResultCorrectAnswerTC.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import UIKit

class ResultCorrectAnswerTC: ParentTC {
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblAnswer: UILabel!
    
    func configure(answer: PresentableAnswer) {
        lblQuestion.text = answer.question
        lblAnswer.text = answer.answer
    }
}
