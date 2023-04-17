//
//  UpdateUserViewModel.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//


import Foundation
import Combine

protocol UpdateUserViewModelProtocol {
    func updateUser(user: UserStruct, onComplete:@escaping() -> ())
}

final class UpdateUserViewModel : UpdateUserViewModelProtocol {
    
    public var user: UserStruct? = nil
    
    var dataManager: DataManagerProtocol
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
}

extension UpdateUserViewModel {
    
    func updateUser(user: UserStruct, onComplete: @escaping () -> ()) {
        dataManager.updateUser(for: user)
        onComplete()
    }
}
