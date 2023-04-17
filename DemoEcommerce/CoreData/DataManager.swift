//
//  DemoEcommerceDataManager.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import Foundation
import CoreData
import DemoDBFramework

protocol DataManagerProtocol {
    func getUser(_ email: String) -> UserStruct?
    func getAllUser() -> [UserStruct]
    func insertUser(for user: UserStruct, onConflict:@escaping() -> ())
    func updateUser(for user: UserStruct)
    func deleteUser(_ email: String)
}

class DataManager: DataManagerProtocol {
    
    static let shared: DataManagerProtocol = DataManager()
    
    var dbHelper: DemoCoreDataHelper = DemoCoreDataHelper.shared
    
    private init() {
        dbHelper.setDbName(dbName: "DemoDB")
    }
    
    func get(_ email: String) -> UserEntity? {
        let predicate = NSPredicate(
            format: "email = %@",
            email as CVarArg)
        let result = dbHelper.get(UserEntity.self, predicate: predicate)
        switch result {
        case .success(let item):
            return item
        case .failure(_):
            return nil
        }
    }
}

extension DataManager {
    
    func getUser(_ email: String) -> UserStruct? {
        let predicate = NSPredicate(
            format: "email = %@",
            email as CVarArg)
        let result = dbHelper.get(UserEntity.self, predicate: predicate)
        switch result {
        case .success(let item):
            return item?.convertToUser()
        case .failure(_):
            return nil
        }
    }
    
    func insertUser(for user: UserStruct, onConflict:@escaping() -> ()) {
        let currentUser = get(user.email)
        if(currentUser != nil) {
            onConflict()
        }
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserEntity", in: dbHelper.context)
        let userObject = UserEntity(entity: entityDescription!, insertInto: dbHelper.context)
        userObject.userName = user.userName
        userObject.email = user.email
        userObject.phoneNumber = user.phoneNumber
        dbHelper.create(userObject)
    }
    
    func updateUser(for user: UserStruct) {
        guard let currentUser = get(user.email) else { return }
        currentUser.phoneNumber = user.phoneNumber
        currentUser.userName = user.userName
        currentUser.email = user.email
        dbHelper.update(currentUser)
    }
 
    func deleteUser(_ email: String) {
        guard let currentUser = get(email) else { return }
        dbHelper.delete(currentUser)
    }
    
    func getAllUser() -> [UserStruct] {
        let entityDescription = NSEntityDescription.entity(forEntityName: "UserEntity", in: dbHelper.context)
        let result: Result<[UserEntity], Error> = dbHelper.getAll(UserEntity.self, entityDescription!)
        switch result {
        case .success(let users):
            return users.map { $0.convertToUser()}
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }
    
}

