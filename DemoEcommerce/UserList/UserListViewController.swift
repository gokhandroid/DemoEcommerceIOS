//
//  UserListViewController.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import Foundation
import UIKit

class UserListViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBAction func addUserClicked(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CreateUserViewController") as? CreateUserViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBOutlet weak var userListTableView: UITableView!
        
    lazy var viewModel: UserListViewModel = UserListViewModel()
    
    override func viewDidLoad() {
                
        userListTableView.register(UserListTableViewCell.nib(), forCellReuseIdentifier: UserListTableViewCell.identifier)
        userListTableView.dataSource = self
        userListTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getAll {
            self.userListTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = viewModel.getUser(position: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as! UserListTableViewCell
        cell.setData(username: item.userName, email: item.email, phoneNumber: item.phoneNumber)
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                    leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
         let editAction = UIContextualAction(style: .normal, title:  "Edit", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "UpdateUserViewController") as? UpdateUserViewController
             vc?.setUserData(self.viewModel.getUser(position: indexPath.row))
             self.navigationController?.pushViewController(vc!, animated: true)
         })
         editAction.backgroundColor = .blue

         return UISwipeActionsConfiguration(actions: [editAction])
     }

     func tableView(_ tableView: UITableView,
                    trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
     {
         let deleteAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             self.viewModel.deleteUser(indexPath.row, onComplete: {
                 
             })
             tableView.beginUpdates()
             tableView.deleteRows(at: [indexPath], with: .automatic)
             tableView.endUpdates()
         })
         deleteAction.backgroundColor = .red

         return UISwipeActionsConfiguration(actions: [deleteAction])
     }
}
