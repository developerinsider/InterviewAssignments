//
//  ContactDetailsViewModelTests.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 19/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class ContactDetailsViewModelTests: XCTestCase {

    var contact: Contact!
    var contactDetailsViewModel: ContactDetailsViewModel!
    
    override func setUp() {
        contact = MockContact.getComplete()
        
        let session = MockSession()
        let client = HTTPClient(session: session)
        contactDetailsViewModel = ContactDetailsViewModel(contact: contact, client: client)
    }
    
    override func tearDown() {
        
    }

    func testCheckContactViewModel() {
        XCTAssert(contactDetailsViewModel.name == "Anonymous", "Contact full name mismatch.")
        XCTAssert(contactDetailsViewModel.imageURL == URL(string: "image.png"), "Contact image url mismatch.")
        XCTAssert(contactDetailsViewModel.isFavorite == false, "Contact favorite status mismatch.")
        XCTAssert(contactDetailsViewModel.telURL == URL(string: "tel://+910987654321"), "Contact phone number url mismatch.")
        XCTAssert(contactDetailsViewModel.messageURL == URL(string: "sms://+910987654321"), "Contact message url mismatch.")
        XCTAssert(contactDetailsViewModel.mailURL == URL(string: "mailto://vc@gmail.com"), "Contact email url mismatch.")
    }

}
