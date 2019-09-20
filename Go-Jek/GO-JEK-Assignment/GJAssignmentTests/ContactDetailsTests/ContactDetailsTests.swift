//
//  ContactDetailsViewModelTest.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class ContactDetailsTests: XCTestCase {

    var contact: Contact!
    var contactDetailsViewModel: ContactDetailsViewModel!
    
    override func setUp() {
        contact = MockContact.getPartial()
        
        let session = MockSession()
        let client = HTTPClient(session: session)
        contactDetailsViewModel = ContactDetailsViewModel(contact: contact, client: client)
    }

    override func tearDown() {
        
    }
    
    func testEditBarButtonTitle() {
        XCTAssert(contactDetailsViewModel.editBarButtonTitle == "Edit", "Contact edit button title mismatch.")
    }
    
    func testContactAPIResponse() {
        let expectation = self.expectation(description: "No response recevice from contact list API.")
        
        contactDetailsViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        
        contactDetailsViewModel.contact.bind { (contact) in
            if contact.phoneNumber != nil {
                expectation.fulfill()
            }
        }
        
        contactDetailsViewModel.getContactDetails()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testUpdateContactFavoriteStatus() {
        let expectation = self.expectation(description: "No response recevice from contact list API.")        
        let oldStatus = contact.favorite

        contactDetailsViewModel.error.bind { (error) in
            XCTAssert(error == nil, error!.localizedDescription)
        }
        
        contactDetailsViewModel.contact.bind { (contact) in
            if contact.favorite != oldStatus {
                expectation.fulfill()
            }
        }
        
        contactDetailsViewModel.updateFavourite()
        self.waitForExpectations(timeout: 100.0, handler: nil)
    }
}
