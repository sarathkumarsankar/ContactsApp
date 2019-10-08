//
//  ContactsViewModelTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactsViewModelTests: XCTestCase {
    var contactsViewModel = ContactsViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetContact() {
        let expect = expectation(description: "status is true")
        contactsViewModel.fetchContacts(urlString: "http://gojek-contacts-app.herokuapp.com/contacts", completionHandler: { (status, data) in
            XCTAssertEqual(status, true)
            expect.fulfill()
            
        }) { (status, error) in
            XCTAssertEqual(status, false)
            expect.fulfill()
        }
        waitForExpectations(timeout: 60) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}

