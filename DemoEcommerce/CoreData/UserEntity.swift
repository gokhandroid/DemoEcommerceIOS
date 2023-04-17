//
//  User.swift
//  DemoEcommerce
//
//  Created by Gökhan Ünal on 15.04.2023.
//

import CoreData

@objc(UserEntity)
final class UserEntity: NSManagedObject {
    @NSManaged var userName: String
    @NSManaged var phoneNumber: String
    @NSManaged var email: String
}

extension UserEntity {
    func convertToUser() -> UserStruct {
        UserStruct(
            email: email, userName: userName, phoneNumber: phoneNumber
        )
    }
}
