//
//  ContactTableView.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 07/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit
protocol ContactTableViewDelegate:class {
    func didSelctRowAt(indexPath: IndexPath)
}

class ContactTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
          super.init(frame: frame, style: style)
      }
    
      required init?(coder aDecoder: NSCoder) {
          super.init(coder: aDecoder)
      }
    
    weak var contactTableViewDelegate: ContactTableViewDelegate?
    var dataSourceArray = [SectionModel]() {
        didSet {
            self.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        /// Setting TableView delegate and DataSource
        self.delegate = self
        self.dataSource = self
    }
}

// MARK: -  UITableViewDelegate Methods
extension ContactTableView: UITableViewDelegate {
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
        self.contactTableViewDelegate?.didSelctRowAt(indexPath: indexPath)
    }
    
}

// MARK: -  UITableViewDataSource Methods
extension ContactTableView: UITableViewDataSource {
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



