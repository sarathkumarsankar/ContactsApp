//
//  ContactsModel.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactsModel: Codable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var profile_pic: String?
    var favorite: Bool?
    var url: String?
}

class SectionModel: Codable {
    var letter: String?
    var names: [ContactsModel]?
}
