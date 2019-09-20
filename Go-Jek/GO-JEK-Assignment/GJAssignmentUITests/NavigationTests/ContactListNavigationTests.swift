//
//  NavigationTests.swift
//  GJAssignmentUITests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest

class NavigationTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContactListNavigation() {
        let contactNavigationBar = app.navigationBars["Contact"]
        XCTAssertTrue(contactNavigationBar.exists, "Contact list navigation bar not exist.")
        
        let groupButton = contactNavigationBar.buttons["Groups"]
        XCTAssertTrue(groupButton.exists, "Group button not exists in contact list navigation bar.")
        
        let addButton = contactNavigationBar.buttons["Add"]
        XCTAssertTrue(addButton.exists, "Group button not exists in contact list navigation bar.")
    }
    
    func testAddContactNavigationFromContactList() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addContactNavigationBar = app.navigationBars["GJAssignment.AddContactView"]
        XCTAssertTrue(addContactNavigationBar.exists, "Add contact navigation bar not exist.")
    }
    
    func testContactDetailsNavigationFromContactList() {
        let myTable = app.tables.matching(identifier: "contactListTableView")
        let cell = myTable.cells.element(matching: .cell, identifier: "contactTableViewCell_0_0")

        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: cell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 30.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Failed time out waiting for rate")
        
        cell.tap()
        
        let contactNavigationBar = app.navigationBars["Contact"]
        let backButton = contactNavigationBar.buttons["Contact"]
        XCTAssertTrue(contactNavigationBar.exists && backButton.exists, "Contact list navigation bar not exist.")
    }
}
