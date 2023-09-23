//
//  QuestionVC.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import UIKit

// MARK: - VC
class QuestionVC: ParentVC {
    @IBOutlet weak var lblHeader: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let question: String
    let options: [String]
    let selection: ([String])-> Void
    
    init?(question: String,
          options: [String],
          selection: @escaping ([String])-> Void,
          coder: NSCoder) {
        self.question = question
        self.options = options
        self.selection = selection
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(question:options:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - IBAction(s)
extension QuestionVC {
    
    @IBAction func btnSubmitTap() {
        submitSelectedOptions()
    }
}

// MARK: - Helper method(s)
extension QuestionVC {
    
    private func setupUI() {
        lblHeader.text = question
        tableView.allowsMultipleSelection = true
        tableView.register(QuestionOptionTC.nib,
                           forCellReuseIdentifier: QuestionOptionTC.reuseIdentifier)
        tableView.reloadData()
    }
    
    private func submitSelectedOptions() {
        let selectedAnswer: [String] = tableView.indexPathsForSelectedRows?.map { options[$0.row] } ?? []
        selection(selectedAnswer)
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
