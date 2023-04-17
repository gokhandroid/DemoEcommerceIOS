//
//  UserListViewModel.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import Foundation
import Combine

protocol UserListViewModelProtocol {
    func getAll(onComplete: @escaping () -> ())
    func getUser(position: Int) -> UserStruct
    func getNumberOfRows() -> Int
    func deleteUser(_ row: Int, onComplete: @escaping () -> ())
}

final class UserListViewModel : UserListViewModelProtocol {
    
    var dataManager: DataManagerProtocol
    private var userList = [UserStruct]()
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

extension UserListViewModel {
    
    func getAll(onComplete: @escaping () -> ()) {
        userList = dataManager.getAllUser()
        onComplete()
    }
    
    func getNumberOfRows() -> Int {
        return userList.count
    }
    
    func getUser(position: Int) -> UserStruct {
        return userList[position]
    }
    
    func deleteUser(_ row: Int, onComplete: @escaping () -> ()) {
        dataManager.deleteUser(userList[row].email)
        userList.remove(at: row)
    }
}
