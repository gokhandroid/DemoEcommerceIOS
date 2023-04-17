//
//  UpdateUserViewController.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import UIKit

class UpdateUserViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTField: UITextField!
    @IBOutlet weak var phoneNumberTField: UITextField!
    @IBOutlet weak var emailTField: UITextField!
    
    lazy var viewModel: UpdateUserViewModel = UpdateUserViewModel()
    
    func setUserData(_ user: UserStruct) {
        viewModel.user = user
    }
    
    override func viewDidLoad() {
                
        let user = viewModel.user
        guard let currentUser = user else { return }
        usernameTField.text = currentUser.userName
        emailTField.text = currentUser.email
        phoneNumberTField.text = currentUser.phoneNumber
    }
    
    @IBAction func updateUserClicked(_ sender: Any) {
        
        let user = viewModel.user
        guard var currentUser = user else { return }
        
        let username = usernameTField.text!
        let email = emailTField.text!
        let phoneNumber = phoneNumberTField.text!
    
        
        if(!phoneNumber.isValidPhone) {
            showAlertDialog("Please enter a valid phone number")
            return
        }
        
        if(username.isEmpty) {
            showAlertDialog("Please enter a valid username")
            return
        }
        
        currentUser.email = email
        currentUser.phoneNumber = phoneNumber
        currentUser.userName = username
        
        viewModel.updateUser(user: currentUser, onComplete: {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        })
    }

    func showAlertDialog(_ message : String) {
        let alertController:UIAlertController = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
