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

class ContactDetailModel: Codable {
    var id: Int?
    var first_name: String?
    var last_name: String?
    var email: String?
    var phone_number: String?
    var profile_pic: String?
    var favorite: Bool?
    var created_at: String?
    var updated_at: String?
}
