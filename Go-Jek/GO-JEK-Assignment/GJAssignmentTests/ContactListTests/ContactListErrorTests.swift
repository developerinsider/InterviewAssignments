//
//  ContactListErrorTests.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class ContactListErrorTests: XCTestCase {

    var contactListViewModel: ContactListViewModel!
    
    override func setUp() {
        let session = BadMockSession()
        let client = HTTPClient(session: session)
        contactListViewModel = ContactListViewModel(client: client)
    }
    
    override func tearDown() {
        
    }
    
    func testContactsAPIFailedResponse() {
        let expectation = self.expectation(description: "No error return by API.")
        
        contactListViewModel.error.bind { (error) in
            if error != nil {
                expectation.fulfill()
            }
        }
        
        contactListViewModel.getContacts()
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
}
