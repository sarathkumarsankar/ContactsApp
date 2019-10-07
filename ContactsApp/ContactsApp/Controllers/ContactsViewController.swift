//
//  ContactsViewController.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    @IBOutlet weak var contactsTableView: UITableView!
    var viewModel = ContactsViewModel()
    
    var dataSourceArray = [SectionModel]() {
        didSet {
            contactsTableView.reloadData()
        }
    }
    
    // MARK: -  View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Contacts"
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
            self?.dataSourceArray = (self?.viewModel.grouping(model: response as! [ContactsModel]))!
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
    }
    
    @objc func addTapped() {
        let editContactVC = EditContactViewController.instantiateFromStoryboard()
        editContactVC.type = FeatureType.add
        self.navigationController?.pushViewController(editContactVC, animated: true)
    }
}

// MARK: -  UITableViewDelegate Methods
extension ContactsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSourceArray[section].letter
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return dataSourceArray.map{$0.letter!}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = dataSourceArray[indexPath.section].names?[indexPath.row].id
        let contactDetailVC = ContactDetailViewController.instantiateFromStoryboard()
        contactDetailVC.contactId = id
        contactDetailVC.indexPath = indexPath
        self.navigationController?.pushViewController(contactDetailVC, animated: true)
    }
    
}

// MARK: -  UITableViewDataSource Methods
extension ContactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArray[section].names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.contactTableViewCell, for: indexPath) as! ContactTableViewCell
        cell.configureCell(model: (dataSourceArray[indexPath.section].names?[indexPath.row])!, indexPath: indexPath)
        return cell
    }
}


