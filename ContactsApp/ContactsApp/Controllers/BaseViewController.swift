//
//  BaseViewController.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    let actiVityIndicator = UIActivityIndicatorView()
    
    // MARK: -  View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpLoadingIndicator()
        self.setupHideKeyboardOnTap()
        // Do any additional setup after loading the view.
    }
    
    // MARK: -  Set up loading indicator
    func setUpLoadingIndicator() {
        actiVityIndicator.center = self.view.center
        actiVityIndicator.style = UIActivityIndicatorView.Style.large
        view.addSubview(actiVityIndicator)
    }
    
    // MARK: -  Show loading indicator
    func showLoadingIndicator() {
        actiVityIndicator.startAnimating()
    }
    
    // MARK: -  Hide loading indicator
    func hideLoadingIndicator() {
        actiVityIndicator.stopAnimating()
        actiVityIndicator.removeFromSuperview()
    }
    
    // MARK: -  Show Alert
    func showAlert(message: String?) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /// Call this once to dismiss open keyboards by tapping anywhere in the view controller
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }

    /// Dismisses the keyboard from self.view
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }

}
