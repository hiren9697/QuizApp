//
//  QuestionVCTests.swift
//  QuizeAppTests
//
//  Created by Hirenkumar Fadadu on 16/09/23.
//

import XCTest
@testable import QuizeApp

final class QuestionVCTests: XCTestCase {
    func test_viewDidLoad_rendersQuestionHeader() {
        let question = "Q1"
        let sut = makeSUT(question: question)
        XCTAssertEqual(sut.lblHeader.text, question)
    }
    
    func test_viewDidLoad_rendersOption() {
        XCTAssertEqual(makeSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(makeSUT(options: ["O1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(makeSUT(options: ["O1", "O2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionText() {
        XCTAssertEqual(makeSUT(options: ["O1"]).tableView.getOptionText(at: 0), "O1")
        XCTAssertEqual(makeSUT(options: ["O1", "O2"]).tableView.getOptionText(at: 0), "O1")
        XCTAssertEqual(makeSUT(options: ["O1", "O2"]).tableView.getOptionText(at: 1), "O2")
        XCTAssertEqual(makeSUT(options: ["O1", "O2", "O3"]).tableView.getOptionText(at: 0), "O1")
        XCTAssertEqual(makeSUT(options: ["O1", "O2", "O3"]).tableView.getOptionText(at: 1), "O2")
        XCTAssertEqual(makeSUT(options: ["O1", "O2", "O3"]).tableView.getOptionText(at: 2), "O3")
    }
}

// MARK: - Helper method(s)
private extension QuestionVCTests {
    private func makeSUT(question: String = "",
                         options: [String] = [])-> QuestionVC {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(identifier: "QuestionVC") { coder in
            return QuestionVC(question: question, options: options, coder: coder)!
        }
        _ = vc.view
        return vc
    }
}

private extension UITableView {
    func getCell(at row: Int)-> UITableViewCell? {
        return cellForRow(at: IndexPath(row: row, section: 0))
    }
    
    func getOptionText(at row: Int)-> String {
        let cell = getCell(at: row) as! QuestionOptionTC
        return cell.lblOption.text!
    }
}
