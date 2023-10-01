//
//  SubmitButtonController.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 30/09/23.
//

import UIKit

class SubmitButtonController: NSObject {
    let answerCallback: ([String])-> Void
    let button: UIBarButtonItem
    var model: [String] = []
    
    init(answerCallback: @escaping ([String]) -> Void,
         button: UIBarButtonItem) {
        self.answerCallback = answerCallback
        self.button = button
        super.init()
        setup()
    }
    
    private func setup() {
        button.action = #selector(buttonAction)
        button.target = self
    }
    
    @objc func buttonAction() {
        answerCallback(model)
    }
    
    func update(_ selection: [String]) {
        model = selection
        button.isEnabled = !selection.isEmpty
    }
}
