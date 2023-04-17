//
//  CreateUserViewModel.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//


import Foundation
import Combine

protocol CreateUserViewModelProtocol {
    func createUser(user: UserStruct, onComplete:@escaping() -> (), onConflict: @escaping () -> ())
    func getAll(onComplete: @escaping (_ list: [UserStruct]) -> ())
}

final class CreateUserViewModel : CreateUserViewModelProtocol {
    
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

extension CreateUserViewModel {
    
    func createUser(user: UserStruct, onComplete: @escaping () -> (), onConflict: @escaping () -> ()) {
        dataManager.insertUser(for: user, onConflict: onConflict)
        onComplete()
    }
    
    func getAll(onComplete: @escaping (_ list: [UserStruct]) -> ()) {
        let userList = dataManager.getAllUser()
        onComplete(userList)
    }
}
