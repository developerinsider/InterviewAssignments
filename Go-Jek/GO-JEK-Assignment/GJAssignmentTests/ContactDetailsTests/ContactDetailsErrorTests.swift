//
//  ContactDetailsErrorTests.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class ContactDetailsErrorTests: XCTestCase {

    var contact: Contact!
    var contactDetailsViewModel: ContactDetailsViewModel!
    
    override func setUp() {
        contact = MockContact.getPartial()
        
        let session = BadMockSession()
        let client = HTTPClient(session: session)
        contactDetailsViewModel = ContactDetailsViewModel(contact: contact, client: client)
    }
    
    override func tearDown() {
        
    }
    
    func testContactsAPIFailedResponse() {
        let expectation = self.expectation(description: "No error returns by contact API.")
        
        contactDetailsViewModel.error.bind { (error) in
            if error != nil {
                expectation.fulfill()
            }
        }
        
        contactDetailsViewModel.getContactDetails()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
