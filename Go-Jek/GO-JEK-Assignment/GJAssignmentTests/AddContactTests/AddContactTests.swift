//
//  AddContactViewModelTest.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class AddContactTests: XCTestCase {
    
    var addContactViewModel: AddContactViewModel!
    
    override func setUp() {
        let session = MockSession()
        let client = HTTPClient(session: session)
        addContactViewModel = AddContactViewModel(contact: nil, client: client)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCancelBarButtonTitle() {
        XCTAssert(addContactViewModel.cancelBarButtonTitle == "Cancel", "Cancel button title mismatch.")
    }
    
    func testDoneBarButtonTitle() {
        XCTAssert(addContactViewModel.doneBarButtonTitle == "Done", "Done button title mismatch.")
    }
    
    func testAddContact() {
        addContactViewModel.contact.value = MockContact.getComplete()
        
        let expectation = self.expectation(description: "No response recevice from contact list API.")
        
        addContactViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        addContactViewModel.isContactSync.bind { (isSync) in
            if isSync {
                expectation.fulfill()
            }
        }
        
        addContactViewModel.syncContact()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testAddContactResponse() {
        addContactViewModel.contact.value = MockContact.getComplete()
        
        var isContactSync = false
        let expectation = self.expectation(description: "No response recevice from contact list API.")
        
        addContactViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        addContactViewModel.isContactSync.bind { (isSync) in
            isContactSync = isSync
        }
        addContactViewModel.contact.bind { (contact) in
            if isContactSync {
                XCTAssert(contact.firstName == "Anonymous", "Contact fist name mismatch.")
                XCTAssert(contact.lastName == "Anonymous", "Contact last name mismatch.")
                XCTAssert(contact.phoneNumber == "+910987654321", "Contact phone number mismatch.")
                XCTAssert(contact.email == "vc@gmail.com", "Contact phone number mismatch.")
                XCTAssert(contact.favorite == false, "Contact favorite status mismatch.")
                expectation.fulfill()
            }
        }
        
        addContactViewModel.syncContact()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
