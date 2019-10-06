//
//  ServiceUrl.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit


struct ServiceURL {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
    static let contacts = "/contacts"
    static let contactDeatail = "/contacts"
}

enum ErrorType: String {
    case notFound = "Not Found"
    case validationError = "Validation Errors"
    case internalServerError = "Internal Server Error"
    case badRequest = "Bad Request"
    case tryAgain = "Try again later"
    case internetNotThere = "Please check the internet connectivity"
}

struct ErrorModel {
    public var message: String?
    public var errorCode: Int?

    static func checkErrorCode(_ errorCode: Int) -> String {
        switch errorCode {
        case 400:
            return ErrorType.badRequest.rawValue
        case 422:
            return ErrorType.validationError.rawValue
        case 500:
            return ErrorType.internalServerError.rawValue
        case 404:
            return ErrorType.notFound.rawValue
        default:
            return ErrorType.tryAgain.rawValue
        }
    }
}

struct CellIdentifier {
    static let contactTableViewCell = "ContactTableViewCell"
}

