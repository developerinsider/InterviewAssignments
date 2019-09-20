//
//  ContactDetailsNavigationTests.swift
//  GJAssignmentUITests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest

class ContactDetailsNavigationTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContactDetailsNavigation() {
        tapContactListFirstCell()
        
        let contactNavigationBar = app.navigationBars["Contact"]
        let backButton = contactNavigationBar.buttons["Contact"]
        XCTAssertTrue(backButton.exists, "Back button not exist in navigation bar.")
        
        let editButton = contactNavigationBar.buttons["Edit"]
        XCTAssertTrue(editButton.exists, "Back button not exist in navigation bar.")
    }
    
    func testContactEditNavigationFromContactDetails() {
        tapContactListFirstCell()
        let contactNavigationBar = app.navigationBars["Contact"]
        
        let editButton = contactNavigationBar.buttons["Edit"]
        XCTAssertTrue(editButton.exists, "Back button not exist in navigation bar.")
        
        editButton.tap()
        
        let editNavigationBar = app.navigationBars["GJAssignment.AddContactView"]
        XCTAssertTrue(editNavigationBar.exists, "Edit navigation bar not exist.")
    }
    
    private func tapContactListFirstCell() {
        let myTable = app.tables.matching(identifier: "contactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "contactTableViewCell_0_0")
        
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
        
        cell.tap()
    }

}
