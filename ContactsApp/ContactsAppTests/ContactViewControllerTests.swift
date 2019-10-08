//
//  ContactViewControllerTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactsViewControllerTests: XCTestCase {
    var controller:ContactsViewController!
    
    override func setUp() {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle(for: ContactsViewController.self))
            .instantiateInitialViewController() as? ContactsViewController else {
                return XCTFail("Could not instantiate ViewController from main storyboard")
        }

        controller = vc
        controller.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


}
