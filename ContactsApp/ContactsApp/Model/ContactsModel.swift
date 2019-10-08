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
    init(letter: String?, names: [ContactsModel]?) {
        self.letter = letter
        self.names = names
    }
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
    
    convenience init(id: Int? = nil, first_name: String? = nil, last_name: String? = nil, email: String? = nil, phone_number: String? = nil, profile_pic: String? = nil, favorite: Bool? = nil) {
        self.init()
        self.id =  id
        self.first_name =  first_name
        self.last_name =  last_name
        self.email =  email
        self.phone_number =  phone_number
        self.profile_pic =  profile_pic
        self.favorite =  favorite
    }
}

