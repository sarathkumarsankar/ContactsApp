//
//  ContactsViewController.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    
    @IBOutlet weak var contactsTableView: ContactTableView!
    var viewModel = ContactsViewModel()
    
    // MARK: -  View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
        contactsTableView.contactTableViewDelegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    // MARK: -  Fetch contacts from API
    func fetchData() {
        self.actiVityIndicator.startAnimating()
        viewModel.fetchContacts(urlString: ServiceURL.baseUrl + ServiceURL.contacts, completionHandler: { [weak self] (status, response) in
            self?.actiVityIndicator.stopAnimating()
            self?.contactsTableView?.dataSourceArray = (self?.viewModel.grouping(model: response as! [ContactsModel]))!
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
    }
    
    // MARK: -  Add button click actiom
    @objc func addTapped() {
        let editContactVC = EditContactViewController.instantiateFromStoryboard()
        editContactVC.type = FeatureType.add
        self.navigationController?.pushViewController(editContactVC, animated: true)
    }
}

// MARK: -  ContactTableViewDelegate method
extension ContactsViewController: ContactTableViewDelegate {
    func didSelctRowAt(indexPath: IndexPath) {
        let id = contactsTableView.dataSourceArray[indexPath.section].names?[indexPath.row].id
        let contactDetailVC = ContactDetailViewController.instantiateFromStoryboard()
        contactDetailVC.contactId = id
        contactDetailVC.indexPath = indexPath
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
    }
}

