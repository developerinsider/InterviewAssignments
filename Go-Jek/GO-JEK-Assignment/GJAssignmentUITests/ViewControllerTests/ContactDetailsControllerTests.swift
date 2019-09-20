//
//  ContactDetailsControllerTests.swift
//  GJAssignmentUITests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest

class ContactDetailsControllerTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddContactElementsExistence() {
        tapContactListFirstCell()
        
        let table = app.tables.matching(identifier: "detailsTableView")
        let mobileNumberCell = table.cells.element(matching: .cell, identifier: "detailsTableViewCell_0")
        XCTAssertTrue(mobileNumberCell.exists, "Mobile number table view cell not exist.")
        
        let mobileDescLabel = mobileNumberCell.staticTexts["descLabel"]
        XCTAssertTrue(mobileDescLabel.exists, "Mobile number placeholder label not exist.")
        
        let mobileInfoLabel = mobileNumberCell.staticTexts["infoLabel"]
        XCTAssertTrue(mobileInfoLabel.exists, "Mobile number value label not exist.")
        
        let emailCell = table.cells.element(matching: .cell, identifier: "detailsTableViewCell_1")
        XCTAssertTrue(emailCell.exists, "Email table view cell not exist.")
        
        let emailDescLabel = emailCell.staticTexts["descLabel"]
        XCTAssertTrue(emailDescLabel.exists, "Email placeholder label not exist.")
        
        let emailInfoLabel = emailCell.staticTexts["infoLabel"]
        XCTAssertTrue(emailInfoLabel.exists, "Email value label not exist.")
        
        let contactImageView = app.otherElements.containing(.image, identifier: "contactImageView").firstMatch
        XCTAssertTrue(contactImageView.exists, "Contact image view not exist.")
        
        let callImageView = app.otherElements.containing(.image, identifier: "callActionImage").firstMatch
        XCTAssertTrue(callImageView.exists, "Call image view not exist.")
        
        let msgImageView = app.otherElements.containing(.image, identifier: "messageActionImage").firstMatch
        XCTAssertTrue(msgImageView.exists, "Message image view not exist.")
        
        let emailImageView = app.otherElements.containing(.image, identifier: "emailActionImage").firstMatch
        XCTAssertTrue(emailImageView.exists, "Email image view not exist.")
        
        let favImageView = app.otherElements.containing(.image, identifier: "favoriteActionImage").firstMatch
        XCTAssertTrue(favImageView.exists, "Favorite image view not exist.")
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
