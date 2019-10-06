//
//  ContactTableViewCell.swift
//  ContactsApp
//
//  Created by Sarathkumar S on 05/10/19.
//  Copyright © 2019 Sarathkumar S. All rights reserved.
//

import UIKit
extension UIImageView {
    // MARK: - make image view circle
    public func maskCircle(image: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = image
    }
}

class ContactTableViewCell: UITableViewCell {

   // @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    // MARK: - Configure cell with appropriate data
    func configureCell(model: ContactsModel, indexPath: IndexPath) {
        nameLabel.text = (model.first_name ?? "") + " " + (model.last_name ?? "")
        favouriteImageView.isHidden = !(model.favorite ?? true)
        
        self.profileImageView.image = UIImage(named: "PlaceholderPhoto")
        guard let urlString = model.profile_pic else {
            return
        }
        ImageDownloadManager.shared.downloadImage(url: urlString, index: indexPath, completionHadler: { (image, url, indexPath, error) in
            guard let profImage = image else {
                return
            }
            DispatchQueue.main.async {
                self.profileImageView.maskCircle(image: profImage)
            }
        })

    }
}
