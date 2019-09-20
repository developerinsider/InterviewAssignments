//
//  GJAssignmentTests.swift
//  GJAssignmentTests
//
//  Created by Anonymous on 14/08/19.
//  Copyright © 2019 Anonymous. All rights reserved.
//

import XCTest
@testable import GJAssignment

class ContactViewModelTests: XCTestCase {
    
    var contact: Contact!
    var contactViewModel: ContactViewModel!
    
    override func setUp() {
        contact = MockContact.getPartial()
        contactViewModel = ContactViewModel(contact: contact)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testContactFullName() {
        XCTAssert(contactViewModel.name == "Anonymous", "Complete name mismatch.")
    }
    
    func testFavoriteContact() {
        XCTAssert(contactViewModel.isFavorite == false, "Contact was favorite but view model return contact is not favorite")
    }
    
    func testProfilePicURL() {
        let testURL = URL(string: "image.png")
        XCTAssert(contactViewModel.imageURL == testURL, "Contact profile URL mismatch.")
    }
}
