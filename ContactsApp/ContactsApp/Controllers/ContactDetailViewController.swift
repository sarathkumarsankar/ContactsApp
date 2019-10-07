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
    var isFavourite: Bool?
    var model: ContactDetailModel?
    // MARK: -  View controller life cycle
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
        let editContactVC = EditContactViewController.instantiateFromStoryboard()
        editContactVC.contactDetailModel = model
        editContactVC.type = FeatureType.edit
        self.navigationController?.pushViewController(editContactVC, animated: true)
    }
    
    // MARK: -  Fetch contact detail from API
    func getContactDetail() {
        guard let id = contactId else {
            return
        }
        self.actiVityIndicator.startAnimating()
        viewModel.getContactDetail(urlString: ServiceURL.baseUrl + ServiceURL.contactDeatail, contactId: id, completionHandler: { [weak self] (status, response) in
            DispatchQueue.main.async {
                self?.actiVityIndicator.stopAnimating()
                self?.updateUI(data: response as! ContactDetailModel)
            }
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
    }
    
    // MARK: -  Update UI
    func updateUI(data: ContactDetailModel) {
        model = data
        nameLabel.text = (data.first_name ?? "") + " " + (data.last_name ?? "")
        mobileLabel.text = data.phone_number
        emailLabel.text = data.email
        if data.favorite == true {
            isFavourite = true
            favouriteButton.setImage(UIImage(named: "FavouriteButtonSelected"), for: .normal)
        } else {
            isFavourite = false
            favouriteButton.setImage(UIImage(named: "FavouriteButton"), for: .normal)
        }
        getImage(urlString: data.profile_pic ?? "", indexPath: indexPath!)
    }
    
    // MARK: - Download image
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
    
    // MARK: - Favourite button tapped
    @IBAction func favouriteTapped(_ sender: Any) {
        self.actiVityIndicator.startAnimating()
        viewModel.addFavourite(urlString: ServiceURL.baseUrl + ServiceURL.contacts, contactId: contactId!, favourite: !isFavourite!, completionHandler: { [weak  self] (status, response) in
            DispatchQueue.main.async {
                self?.actiVityIndicator.stopAnimating()
                let data = response as! ContactDetailModel
                if data.favorite == true {
                    self?.isFavourite = true
                    self?.favouriteButton.setImage(UIImage(named: "FavouriteButtonSelected"), for: .normal)
                } else {
                    self?.isFavourite = false
                    self?.favouriteButton.setImage(UIImage(named: "FavouriteButton"), for: .normal)
                }
            }
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
    }
}
