//
//  ViewController.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 14.04.2023.
//

import UIKit
import FlagKit

class CreateUserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var userNameTField: UITextField!
    @IBOutlet weak var emailTField: UITextField!
    @IBOutlet weak var phoneNumberTField: UITextField!
    
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var countryCodeImageView: UIImageView!
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    private let errorMessage = UILabel()

    let countryData = [["name": "United States", "code": "+1", "flag": Flag(countryCode: "US")!],
                        ["name": "United Kingdom", "code": "+44", "flag": Flag(countryCode: "GB")!],
                        ["name": "Germany", "code": "+49", "flag": Flag(countryCode: "DE")!],
                       ]
    
    var viewModel : CreateUserViewModel? = nil
    
    @IBAction func createUser(_ sender: Any) {
        
        let username = userNameTField.text!
        let email = emailTField.text!
        let phoneNumber = phoneNumberTField.text!
        
        if(!email.isValidEmail) {
            showAlertDialog("Please enter a valid email")
            return
        }
        
        let phoneNumberWithCode = countryCodeLabel.text! + phoneNumber
        if(!phoneNumberWithCode.isValidPhone) {
            showAlertDialog("Please enter a valid phone number")
            return
        }
        
        if(username.isEmpty) {
            showAlertDialog("Please enter a valid username")
            return
        }
        
        let user = UserStruct(email: email, userName: username, phoneNumber: phoneNumberWithCode)
        viewModel?.createUser(user: user, onComplete: {
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UserListViewController") as? UserListViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }, onConflict: {
            self.showAlertDialog("Email address already in use")
        })
    }
    
    func createPickerView()
    {
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        countryPickerView.delegate?.pickerView?(countryPickerView, didSelectRow: 0, inComponent: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel = CreateUserViewModel()
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(CreateUserViewController.imageTapped(gesture:)))

        countryCodeImageView.addGestureRecognizer(tapGesture)
        countryCodeImageView.isUserInteractionEnabled = true
        emailTField.delegate = self
        createPickerView()
    }

    @objc func imageTapped(gesture: UIGestureRecognizer) {
            
        if (gesture.view as? UIImageView) != nil {
            self.countryPickerView.isHidden = false
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let country = countryData[row]
        countryCodeLabel.text = "\(country["code"]!)"
        let flag = country["flag"] as? Flag
        countryImageView.image = flag!.image(style: .circle)
        self.countryPickerView.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let parentView = UIView()
        let label = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 30))
        label.textAlignment = .center
        let imageView = UIImageView(frame: CGRect(x: 30, y: 0, width: 30, height:30))
        let country = countryData[row]
        let flag = country["flag"] as? Flag
        imageView.image = flag!.image(style: .circle)
        label.text = "\(country["name"]!) (\(country["code"]!))"
        parentView.addSubview(label)
        parentView.addSubview(imageView)
        return parentView
    }

    func showAlertDialog(_ message : String) {
        let alertController:UIAlertController = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
