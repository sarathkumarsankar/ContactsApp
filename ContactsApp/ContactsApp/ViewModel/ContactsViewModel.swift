//
//  ContactsViewModel.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactsViewModel: NSObject {
    var contactsModel: [ContactsModel]?
    let baseService = ServiceManager()

    // MARK: - Get contact from API
    func fetchContacts(urlString: String, completionHandler: @escaping DataClosure, failureHandler: @escaping FailureClosure) {
        baseService.callWebService(withURL: urlString + ".json", serviceType: .GET, completionHandler: {(status, data) in            
            do {
                let response = try JSONDecoder().decode([ContactsModel].self, from: data ?? Data())
                self.contactsModel = response
                completionHandler(status, response)
            } catch let error {
                print(error)
                failureHandler(false, "fail to serialize")
            }

        }, failureHandler: { (status, error) in
            failureHandler(status, error)
        })
    }
    
    // MARK: - convert array to group dictionary
    func grouping(model: [ContactsModel]) -> [SectionModel] {
        let groupedDictionary = Dictionary(grouping: model) { String($0.first_name?.prefix(1).uppercased() ?? "") }
        let sortedDictionary = groupedDictionary.sorted(by: { $0.0 < $1.0 })
        var array = [SectionModel]()
        for (key, values) in sortedDictionary {
            let sectionModel = SectionModel()
            sectionModel.letter = key
            sectionModel.names =  sortedArray(array: values)
            array.append(sectionModel)
        }
        return array
    }
    
    // MARK: - Sort values in Descending order
    func sortedArray(array: [ContactsModel]) -> [ContactsModel] {
        let sortedValues = array.sorted(by: { (firstObject, secondObject) -> Bool in
           let first_Name = firstObject.first_name ?? ""
           let second_Name = firstObject.last_name ?? ""
           return (first_Name.localizedCaseInsensitiveCompare(second_Name) == .orderedDescending)
        })
        return sortedValues
    }

}
