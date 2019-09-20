//
//  ContactListViewModelTest.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 18/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
import CoreData
@testable import GJAssignment

class ContactListTests: XCTestCase {

    var contactListViewModel: ContactListViewModel!
    
    override func setUp() {
        let session = MockSession()
        let client = HTTPClient(session: session)
        contactListViewModel = ContactListViewModel(client: client)
    }

    override func tearDown() {
        
    }

    func testContactListTitle() {
        XCTAssert(contactListViewModel.title == "Contact", "Contact list title mismatch.")
    }
    
    func testGroupBarButtonTitle() {
        XCTAssert(contactListViewModel.groupBarButtonTitle == "Groups", "Contact list title mismatch.")
    }
    
    func testContactsAPISuccessResponse() {
        let expectation = self.expectation(description: "No response recevice from contact list API.")
        
        contactListViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        
        contactListViewModel.contacts.bind { (contacts) in
            if contacts != nil {
                expectation.fulfill()
            }
        }
        
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testContactsAPIResultCount() {
        let expectation = self.expectation(description: "Invalid number of contact returns by contact list API.")
        
        contactListViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        
        contactListViewModel.contacts.bind { (contacts) in
            if contacts?.count == 3 {
                expectation.fulfill()
            }
        }
        
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testConactsAPIObject() {
        let expectation = self.expectation(description: "Invalid number of contact returns by contact list API.")
        
        contactListViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        
        contactListViewModel.contacts.bind { (contacts) in
            if let contact = contacts?[0] {
                XCTAssert(contact.sectionTitle == "V", "Contact section title is incorrect.")
                XCTAssert(contact.fullName == "Anonymous", "Contact full name is incorrect.")
                XCTAssert(contact.firstName == "Anonymous", "Contact first name is incorrect.")
                XCTAssert(contact.lastName == "Anonymous", "Contact last name is incorrect.")
                XCTAssert(contact.favorite == false, "Contact favorite status is incorrect.")
                XCTAssert(contact.phoneNumber == nil, "Contact phone number must be nil.")
                XCTAssert(contact.email == nil, "Contact email must be nil.")
                expectation.fulfill()
            }
        }
        
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
