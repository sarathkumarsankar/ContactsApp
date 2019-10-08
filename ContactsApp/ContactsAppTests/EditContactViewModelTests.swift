//
//  EditContactViewModelTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class EditContactViewModelTests: XCTestCase {
    var editContactViewModel = EditContactViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEditContact() {
        let expect = expectation(description: "status is true")
        editContactViewModel.editContact(urlString: "http://gojek-contacts-app.herokuapp.com/contacts", contactId: 11524, firstName: "Febri", lastName: "Adrian", mobile: "8484864723", email: "a@gmail.com", completionHandler: { (status, data) in
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
    
    func testAddContact() {
        let expect = expectation(description: "status is true")
        editContactViewModel.addContact(urlString: "http://gojek-contacts-app.herokuapp.com/contacts", firstName: "sarath", lastName: "kuma", mobile: "9373747332", email: "a@gmail.com", completionHandler: { (status, data) in
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
