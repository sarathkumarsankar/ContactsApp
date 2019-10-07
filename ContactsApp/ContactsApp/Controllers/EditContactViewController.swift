//
//  EditContactViewController.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 07/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class EditContactViewController: BaseViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var contactDetailModel: ContactDetailModel?
    var viewModel = EditContactViewModel()
    var type: FeatureType?

    // MARK: -  View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        let backButton = UIBarButtonItem()
        backButton.title = "Cancel"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        NotificationCenter.default.addObserver(self, selector: #selector(EditContactViewController.keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(EditContactViewController.keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        if type == .edit {
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }
    
    /// Intantiates and load View Controller from StoryBoard
    ///
    /// - Returns: ContactDetailViewController as an instance
    class func instantiateFromStoryboard() -> EditContactViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! EditContactViewController
    }
    // MARK: -  Update text field
    func updateUI() {
        firstNameTextField.text = contactDetailModel?.first_name
        lastNameTextField.text = contactDetailModel?.last_name
        mobileTextField.text = contactDetailModel?.phone_number
        emailTextField.text = contactDetailModel?.email
    }
    
    // MARK: -  Done button click actiom
    @objc func doneTapped() {
        // Edit contact tapped
        if type == .edit {
        guard let id = contactDetailModel?.id else {
            return
        }
        self.actiVityIndicator.startAnimating()
        viewModel.editContact(urlString: ServiceURL.baseUrl + ServiceURL.contactDeatail, contactId: id, firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", mobile: mobileTextField.text ?? "", email: emailTextField.text ?? "", completionHandler: { (status, response) in
            DispatchQueue.main.async {
                self.actiVityIndicator.stopAnimating()
                self.navigationController?.popViewController(animated: true)
            }
        }) { (status, error) in
            self.showAlert(message: error)
            self.actiVityIndicator.stopAnimating()
        }
        // Add contact tapped
        } else {
            self.actiVityIndicator.startAnimating()
            viewModel.addContact(urlString: ServiceURL.baseUrl + ServiceURL.contactDeatail, firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", mobile: mobileTextField.text ?? "", email: emailTextField.text ?? "", completionHandler: { (status, response) in
                DispatchQueue.main.async {
                    self.actiVityIndicator.stopAnimating()
                    self.navigationController?.popViewController(animated: true)
                }
            }) { (status, error) in
                self.showAlert(message: error)
                self.actiVityIndicator.stopAnimating()
            }

        }
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
// MARK: -  UITextFieldDelegate method
extension EditContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
