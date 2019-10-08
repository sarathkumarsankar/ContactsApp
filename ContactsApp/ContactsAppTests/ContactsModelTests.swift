//
//  ContactsModelTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactsModelTests: XCTestCase {

    func testContactsHasName() {
        let model =  ContactsModel()
        model.first_name = "sarath"
        model.last_name = "test"
        model.favorite = true
        model.id = 2
        model.profile_pic = ""
        XCTAssertEqual(model.first_name, "sarath")
    }
    
    func testSectionModel() {
        let model =  ContactsModel()
        model.first_name = "sarath"
        model.last_name = "test"
        model.favorite = true
        model.id = 2
        model.profile_pic = ""
        let sectionModel = SectionModel(letter: "A", names: [model])
        XCTAssertNotNil(sectionModel)
    }
    
    func testContactDetailModel() {
        let contactDetailModel =  ContactDetailModel(id: 1110, first_name: "test", last_name: "test", email: "a@gmail.com", phone_number: "9846372333", profile_pic: "", favorite: true)
        XCTAssertNotNil(contactDetailModel)
    }
}
 
