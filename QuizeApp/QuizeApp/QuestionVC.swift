//
//  QuestionVC.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import UIKit

// MARK: - TC
class QuestionOptionTC: UITableViewCell {
    @IBOutlet weak var lblOption: UILabel!
}

// MARK: - VC
class QuestionVC: UIViewController {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let question: String
    let options: [String]
    
    init?(question: String, options: [String], coder: NSCoder) {
        self.question = question
        self.options = options
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(question:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Helper method(s)
extension QuestionVC {
    
    private func setupUI() {
        lblHeader.text = question
        tableView.allowsMultipleSelection = true
        tableView.reloadData()
    }
}

// MARK: - TableView method(s)
extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionOptionTC", for: indexPath) as! QuestionOptionTC
        cell.lblOption.text = options[indexPath.row]
        return cell
    }
}
