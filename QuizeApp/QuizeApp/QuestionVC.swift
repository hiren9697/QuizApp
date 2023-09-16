//
//  QuestionVC.swift
//  QuizeApp
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import UIKit

// MARK: - VC
class QuestionVC: UIViewController {
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let question: String
    
    init?(question: String, coder: NSCoder) {
        self.question = question
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(question:coder:)")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - TableView method(s)
extension QuestionVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
