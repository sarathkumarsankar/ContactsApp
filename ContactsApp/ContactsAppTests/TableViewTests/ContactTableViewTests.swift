//
//  ContactTableViewTests.swift
//  ContactsAppTests
//
//  Created by Sarathkumar S on 08/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import XCTest
@testable import ContactsApp

class ContactTableViewTests: XCTestCase {
    var tableView = ContactTableView()
    
    override func setUp() {
        var array = [ContactsModel]()
        for number in 0..<20 {
            let data = ContactsModel()
            data.first_name = "Test\(number)"
            data.last_name = "Test\(number)"
            data.favorite = true
            data.id = number
            data.profile_pic = ""
            array.append(data)
        }
        let section1 = SectionModel(letter: "A", names: array)
        let section2 = SectionModel(letter: "B", names: array)
        let sectionModelArray = [section1, section2]
        tableView.dataSourceArray = sectionModelArray
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testTableViewHasContacts() {
        XCTAssertEqual(tableView.dataSourceArray.count, 2,
                       "tableView should have correct number of Contacts")
    }
    
    func testHasZeroSectionsWhenZeroContacts() {
        tableView.dataSourceArray = []
        XCTAssertEqual(tableView.numberOfSections(in: tableView), 0,
                       "TableView should have zero sections when no contacts are present")
    }
    
    func testNumberOfSection() {
        XCTAssertEqual(tableView.numberOfSections(in: tableView), 2)
    }

    func testNumberOfRows() {
        let numberOfRows = tableView.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 20,
                       "Number of rows in table should match number of CONTACTS")
    }

    func testTitleForSection() {
        let title = tableView.tableView(tableView, titleForHeaderInSection: 0)
        XCTAssertEqual(title, "A",
                       "first section should be A")
    }

}
