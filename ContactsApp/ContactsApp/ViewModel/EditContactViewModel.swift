//
//  EditContactViewModel.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 07/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class EditContactViewModel: NSObject {
    let baseService = ServiceManager()

    // MARK: - Edit contact API
    func editContact(urlString: String, contactId: Int,firstName: String, lastName: String, mobile: String, email: String, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        if firstName != "" || lastName != "" || mobile != "" || email != "" {
        baseService.parameter = ["first_name": firstName, "last_name": lastName, "phone_number": mobile, "email": email]
        baseService.callWebService(withURL: urlString + "/" + String(contactId) + ".json", serviceType: .PUT, completionHandler: {(status, data) in
            do {
                let response = try JSONDecoder().decode(ContactDetailModel.self, from: data ?? Data())
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, "fail to serialize")
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
        } else {
            failureHandler(false, ErrorType.emptyField.rawValue)
        }
    }

    // MARK: - Ad new contact API
    func addContact(urlString: String,firstName: String, lastName: String, mobile: String, email: String, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        if firstName != "" || lastName != "" || mobile != "" || email != "" {
            baseService.parameter = ["first_name": firstName, "last_name": lastName, "phone_number": mobile, "email": email, "favorite": false]
        baseService.callWebService(withURL: urlString + ".json", serviceType: .POST, completionHandler: {(status, data) in
            do {
                let response = try JSONDecoder().decode(ContactDetailModel.self, from: data ?? Data())
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, "fail to serialize")
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
        } else {
            failureHandler(false, ErrorType.emptyField.rawValue)
        }
    }

}
