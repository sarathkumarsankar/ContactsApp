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
        // Do any additional setup after loading the view.
    }
    
    // MARK: -  Set up loading indicator
    func setUpLoadingIndicator() {
        actiVityIndicator.center = self.view.center
        actiVityIndicator.style = UIActivityIndicatorView.Style.medium
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

}
