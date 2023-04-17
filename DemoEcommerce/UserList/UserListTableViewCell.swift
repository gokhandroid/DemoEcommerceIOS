//
//  UserListTableViewCell.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    static let identifier = "UserListTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "UserListTableViewCell", bundle: nil)
    }
    
    public func setData(username: String, email: String, phoneNumber: String) {
        emailLabel.text = email
        usernameLabel.text = username
        phoneNumberLabel.text = phoneNumber
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
