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
    
    func test_viewDidLoad_tableViewConfiguration() {
        XCTAssertEqual(makeSUT(allowMultipleSelection: true).tableView.allowsMultipleSelection, true)
        XCTAssertEqual(makeSUT(allowMultipleSelection: false).tableView.allowsMultipleSelection, false)
    }
    
    func test_viewDidLoad_optionSelection() {
        // 1. With one option
        let sut1 = makeSUT(options: ["O1"])
        sut1.tableView.selectRow(at: IndexPath(row: 0, section: 0),
                                 animated: false,
                                 scrollPosition: .top)
        XCTAssertEqual(sut1.tableView.indexPathsForSelectedRows, [IndexPath(row: 0, section: 0)])
        
        // 1. With two option
        let sut2 = makeSUT(options: ["O1", "O2", "O3"], allowMultipleSelection: true)
        // Select first option
        sut2.tableView.selectRow(at: IndexPath(row: 0, section: 0),
                                 animated: false,
                                 scrollPosition: .top)
        XCTAssertEqual(sut2.tableView.indexPathsForSelectedRows, [IndexPath(row: 0, section: 0)])
        // Deselect first option
        sut2.tableView.deselectRow(at: IndexPath(row: 0, section: 0),
                                   animated: false)
        XCTAssertEqual(sut2.tableView.indexPathsForSelectedRows, nil)
        // Select first and third option
        sut2.tableView.selectRow(at: IndexPath(row: 0, section: 0),
                                 animated: false,
                                 scrollPosition: .top)
        sut2.tableView.selectRow(at: IndexPath(row: 2, section: 0),
                                 animated: false,
                                 scrollPosition: .top)
        XCTAssertEqual(sut2.tableView.indexPathsForSelectedRows, [IndexPath(row: 0, section: 0),
                                                                  IndexPath(row: 2, section: 0)])
        // Deselect first option
        sut2.tableView.deselectRow(at: IndexPath(row: 0, section: 0),
                                   animated: false)
        XCTAssertEqual(sut2.tableView.indexPathsForSelectedRows, [IndexPath(row: 2, section: 0)])
    }
    
    func test_optionSelectionFiresSelectionCallback() {
        // Configure
        var selectedOptions: [String] = []
        let sut = makeSUT(options: ["O1", "O2", "O3"],
                          allowMultipleSelection: true,
                          selection: { options in
            selectedOptions = options
        })
        // 1. Select first option
        sut.tableView.selectRow(at: IndexPath(row: 0, section: 0),
                                animated: false,
                                scrollPosition: .none)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(selectedOptions, ["O1"])
        // 2. Unselect first option
        sut.tableView.deselectRow(at: IndexPath(row: 0, section: 0),
                                  animated: false)
        sut.tableView.delegate?.tableView?(sut.tableView, didDeselectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(selectedOptions, [])
        // 3. Select second and third option
        sut.tableView.selectRow(at: IndexPath(row: 1, section: 0),
                                animated: false,
                                scrollPosition: .none)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(selectedOptions, ["O2"])
        sut.tableView.selectRow(at: IndexPath(row: 2, section: 0),
                                animated: false,
                                scrollPosition: .none)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: IndexPath(row: 2, section: 0))
        XCTAssertEqual(selectedOptions, ["O2", "O3"])
    }
}

// MARK: - Helper method(s)
private extension QuestionVCTests {
    private func makeSUT(question: String = "",
                         options: [String] = [],
                         allowMultipleSelection: Bool = false,
                         selection: @escaping ([String])-> Void = { _ in })-> QuestionVC {
        // To test VC with Factory
        /*
        let question = QuestionType.singleAnswer(question)
        let optionDictionary = [question: options]
        let factory = iOSViewControllerFactory(options: optionDictionary)
        let vc = factory.questionViewController(for: question,
                                                answerCallback: { _  in }) as! QuestionVC
         */
        let vc = Storyboards
            .main
            .instantiateViewController(identifier: QuestionVC.storyboardID) { coder in
                return QuestionVC(title: "Question #",
                                  question: question,
                                  options: options,
                                  allowMultipleSelection: allowMultipleSelection,
                                  selection: selection, coder: coder)!
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
