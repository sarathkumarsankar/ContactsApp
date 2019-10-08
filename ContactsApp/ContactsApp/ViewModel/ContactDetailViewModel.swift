//
//  ContactDetailViewModel.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 06/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactDetailViewModel: NSObject {
    let baseService = ServiceManager()

    // MARK: - Get contact detail from API
    func getContactDetail(urlString: String, contactId: Int, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        baseService.callWebService(withURL: urlString + "/" + String(contactId) + ".json", serviceType: .GET, completionHandler: {(status, data) in
            do {
                let response = try JSONDecoder().decode(ContactDetailModel.self, from: data ?? Data())
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, ErrorType.failToSerialize.rawValue)
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
    }
    
    // MARK: - Get getImage from URL
    func getImage(url: String?, indexPath: IndexPath, completionHandler: @escaping DataClosure) {
        guard let urlString = url else {
            return
        }
        ImageDownloadManager.shared.downloadImage(url: urlString, index: indexPath, completionHadler: { (image, url, indexPath, error) in
            guard let profImage = image else {
                return
            }
            DispatchQueue.main.async {
                completionHandler(true, profImage)
            }
        })
    }

    // MARK: - Add to favourite API
    func addFavourite(urlString: String, contactId: Int, favourite: Bool, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        baseService.parameter = ["favorite": favourite]
        baseService.callWebService(withURL: urlString + "/" + String(contactId) + ".json", serviceType: .PUT, completionHandler: {(status, data) in
            do {
                let response = try JSONDecoder().decode(ContactDetailModel.self, from: data ?? Data())
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, ErrorType.failToSerialize.rawValue)
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
    }

}
