//
//  ResultVC.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import UIKit

// MARK: - VC
class ResultVC: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let summary: String
    let answers: [PresentableAnswer]
    
    init?(summary: String,
          answers: [PresentableAnswer],
          coder: NSCoder) {
        self.summary = summary
        self.answers = answers
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(summary:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableView.reloadData()
    }
}

// MARK: - Helper method(s)
extension ResultVC {
    private func setup() {
        lblHeader.text = summary
        tableView.register(ResultCorrectAnswerTC.nib,
                           forCellReuseIdentifier: ResultCorrectAnswerTC.reuseIdentifier)
        tableView.register(ResultWrongAnswerTC.nib,
                           forCellReuseIdentifier: ResultWrongAnswerTC.reuseIdentifier)
    }
}

// MARK: - TableView method(s)
extension ResultVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.isCorrect {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultCorrectAnswerTC.reuseIdentifier,
                                                     for: indexPath) as! ResultCorrectAnswerTC
            cell.configure(answer: answer)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ResultWrongAnswerTC.reuseIdentifier,
                                                     for: indexPath) as! ResultWrongAnswerTC
            cell.configure(answer: answer)
            return cell
        }
    }
}
