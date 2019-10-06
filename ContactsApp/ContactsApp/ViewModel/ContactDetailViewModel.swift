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

    func getContactDetail(urlString: String, contactId: Int, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        baseService.callWebService(withURL: urlString + "/" + String(contactId) + ".json", serviceType: .GET, completionHandler: {(status, data) in
            do {
                let response = try JSONDecoder().decode(ContactDetailModel.self, from: data ?? Data())
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, "faile to serialize")
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
    }
    
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

}
