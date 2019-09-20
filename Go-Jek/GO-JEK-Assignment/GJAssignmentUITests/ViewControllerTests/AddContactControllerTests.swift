//
//  AddContactControllerTests.swift
//  GJAssignmentUITests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest

class AddContactControllerTests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //Test if alret is presented when try to insert empty contact
    func testAddEmptyContact() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let addContactNavigationBar = app.navigationBars["GJAssignment.AddContactView"]
        let doneButton = addContactNavigationBar.buttons["Done"]
        doneButton.tap()
        
        let alertsQuery = app.alerts.firstMatch
        XCTAssertTrue(alertsQuery.exists, "No alert present when all field are empty.")
        
        let alertCancelButton = alertsQuery.buttons["OK"]
        XCTAssertTrue(alertCancelButton.exists, "OK button not exists in error alert.")
    }
    
    //Test all elements of add contact view controller is exists
    func testAddContactElementsExistence() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let selectimagebuttonButton = tablesQuery.buttons["selectImageButton"]
        XCTAssertTrue(selectimagebuttonButton.exists, "Select image button not exists.")
        
        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_0")
        XCTAssertTrue(firstNameCell.exists, "First name table view cell not exists.")
        
        let lastNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_1")
        XCTAssertTrue(lastNameCell.exists, "Last name table view cell not exists.")
        
        let mobileCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_2")
        XCTAssertTrue(mobileCell.exists, "Mobile table view cell not exists.")
        
        let emailCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_3")
        XCTAssertTrue(emailCell.exists, "Email table view cell not exists.")
        
        let firstNameTextField = firstNameCell.textFields["infoTextField"]
        XCTAssertTrue(firstNameTextField.exists, "First name text field not exists.")
        
        let lastNameTextField = lastNameCell.textFields["infoTextField"]
        XCTAssertTrue(lastNameTextField.exists, "Last name text field not exists.")
        
        let mobileTextField = mobileCell.textFields["infoTextField"]
        XCTAssertTrue(mobileTextField.exists, "Mobile name text field not exists.")
        
        let emailTextField = emailCell.textFields["infoTextField"]
        XCTAssertTrue(emailTextField.exists, "Email name text field not exists.")
    }
    
    //Test all elements of add contact are not covered by any other view
    func testAddContactElementsHittable() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let tablesQuery = app.tables
        let selectimagebuttonButton = tablesQuery.buttons["selectImageButton"]
        XCTAssertTrue(selectimagebuttonButton.isHittable, "Select image button not hittable.")
        
        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_0")
        XCTAssertTrue(firstNameCell.isHittable, "First name table view cell not hittable.")
        
        let lastNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_1")
        XCTAssertTrue(lastNameCell.isHittable, "Last name table view cell not hittable.")
        
        let mobileCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_2")
        XCTAssertTrue(mobileCell.isHittable, "Mobile table view cell not hittable.")
        
        let emailCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_3")
        XCTAssertTrue(emailCell.isHittable, "Email table view cell not hittable.")
        
        let firstNameTextField = firstNameCell.textFields["infoTextField"]
        XCTAssertTrue(firstNameTextField.isHittable, "First name text field not hittable.")
        
        let lastNameTextField = lastNameCell.textFields["infoTextField"]
        XCTAssertTrue(lastNameTextField.isHittable, "Last name text field not hittable.")
        
        let mobileTextField = mobileCell.textFields["infoTextField"]
        XCTAssertTrue(mobileTextField.isHittable, "Mobile name text field not hittable.")
        
        let emailTextField = emailCell.textFields["infoTextField"]
        XCTAssertTrue(emailTextField.isHittable, "Email name text field not hittable.")
    }
    
    //Test if all text field can become first responder and match the value after typing
    func testAddContactTextFieldEntry() {
        let contactNavigationBar = app.navigationBars["Contact"]
        let addButton = contactNavigationBar.buttons["Add"]
        addButton.tap()
        
        let table = app.tables.matching(identifier: "addContactTableView")
        let firstNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_0")
        XCTAssertTrue(firstNameCell.exists, "First name table view cell not exist.")
        
        let firstNameTextField = firstNameCell.textFields["infoTextField"]
        firstNameTextField.tap()
        firstNameTextField.typeText("Anonymous")
        guard let firstName = firstNameTextField.value as? String else {
            XCTFail("Invalid first name.")
            return
        }
        XCTAssertTrue(firstName == "Anonymous", "Incorrect entry in first name field")
        
        let lastNameCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_1")
        let lastNameTextField = lastNameCell.textFields["infoTextField"]
        lastNameTextField.tap()
        lastNameTextField.typeText("Anonymous")
        guard let lastName = lastNameTextField.value as? String else {
            XCTFail("Invalid last name.")
            return
        }
        XCTAssertTrue(lastName == "Anonymous", "Incorrect entry in last name field")
        
        let mobileCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_2")
        let mobileTextField = mobileCell.textFields["infoTextField"]
        mobileTextField.tap()
        mobileTextField.typeText("+910987654321")
        guard let mobileNumber = mobileTextField.value as? String else {
            XCTFail("Invalid mobile number.")
            return
        }
        XCTAssertTrue(mobileNumber == "+910987654321", "Incorrect entry in mobile field")
        
        let emailCell = table.cells.element(matching: .cell, identifier: "editTableViewCell_3")
        let emailTextField = emailCell.textFields["infoTextField"]
        emailTextField.tap()
        emailTextField.typeText("vc@gmail.com")
        guard let email = emailTextField.value as? String else {
            XCTFail("Invalid email.")
            return
        }
        XCTAssertTrue(email == "vc@gmail.com", "Incorrect entry in email field")
    }
}
