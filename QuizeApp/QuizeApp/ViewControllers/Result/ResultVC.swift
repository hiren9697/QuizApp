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
    
    init?(summary: String, coder: NSCoder) {
        self.summary = summary
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
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
