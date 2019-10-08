//
//  ContactDetailViewModelTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactDetailViewModelTests: XCTestCase {
    var contactDetailViewModel = ContactDetailViewModel()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetContactDetailTests() {
        let expect = expectation(description: "status is true")
        contactDetailViewModel.getContactDetail(urlString: "http://gojek-contacts-app.herokuapp.com/contacts", contactId: 11110, completionHandler: { (status, data) in
            XCTAssertEqual(status, true)
            expect.fulfill()
        }) { (status, Error) in
            XCTAssertEqual(status, false)
            expect.fulfill()
        }
        waitForExpectations(timeout: 60) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }

    }

    func testGetImageTests() {
        let expect = expectation(description: "status is true")
        let indexPath = IndexPath(row: 1, section: 1)
        contactDetailViewModel.getImage(url: "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/011/188/original/photo?1569231912", indexPath: indexPath) { (status, data) in
            XCTAssertEqual(status, true)
            expect.fulfill()
        }
        waitForExpectations(timeout: 60) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func testAddFavourite() {
        let expect = expectation(description: "status is true")
        contactDetailViewModel.addFavourite(urlString: "http://gojek-contacts-app.herokuapp.com/contacts", contactId: 11188, favourite: true, completionHandler: { (status, data) in
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
