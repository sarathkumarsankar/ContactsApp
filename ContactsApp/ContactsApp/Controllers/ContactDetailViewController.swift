//
//  ContactDetailViewController.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 06/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class ContactDetailViewController: BaseViewController {
    var viewModel = ContactDetailViewModel()
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var contactId: Int?
    var indexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))

        getContactDetail()
        // Do any additional setup after loading the view.
    }
    
    /// Intantiates and load View Controller from StoryBoard
    ///
    /// - Returns: ContactDetailViewController as an instance
    class func instantiateFromStoryboard() -> ContactDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! ContactDetailViewController
    }

    @objc func editTapped() {
        
    }
    
    func getContactDetail() {
        guard let id = contactId else {
            return
        }
        self.actiVityIndicator.startAnimating()
        viewModel.getContactDetail(urlString: ServiceURL.baseUrl + ServiceURL.contactDeatail, contactId: id, completionHandler: { (status, response) in
            self.actiVityIndicator.stopAnimating()
            DispatchQueue.main.async {
                self.updateUI(data: response as! ContactDetailModel)
            }
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
    }
    
    func updateUI(data: ContactDetailModel) {
        nameLabel.text = (data.first_name ?? "") + " " + (data.last_name ?? "")
        mobileLabel.text = data.phone_number
        emailLabel.text = data.email
        if data.favorite == true {
            favouriteButton.setImage(UIImage(named: "FavouriteButtonSelected"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "FavouriteButton"), for: .normal)
        }
        getImage(urlString: data.profile_pic ?? "", indexPath: indexPath!)
    }
    
    func getImage(urlString: String, indexPath: IndexPath) {
        viewModel.getImage(url: urlString, indexPath: indexPath, completionHandler: { [weak self] (status, response) in
            if response as? UIImage != nil {
                self?.profileImageView.maskCircle(image: (response as? UIImage)!)
            }
            })
    }
    
    @IBAction func messageTapped(_ sender: Any) {
    }
    
    
    @IBAction func callTapped(_ sender: Any) {
    }
    
    
    @IBAction func emailTapped(_ sender: Any) {
    }
    
    @IBAction func favouriteTapped(_ sender: Any) {
    }
}
