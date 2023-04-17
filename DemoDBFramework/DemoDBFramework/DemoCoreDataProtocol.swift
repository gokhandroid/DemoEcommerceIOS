//
//  DbUtil.swift
//  DemoDBFramework
//
//  Created by Gökhan Ünal on 14.04.2023.
//

import Foundation
import CoreData

public protocol DemoCoreDataProtocol {
    associatedtype EntityType
    associatedtype PredicateType
    
    func create(_ entity: EntityType)
    func get(_ entityType: EntityType.Type, predicate: PredicateType?) -> Result<EntityType?, Error>
    func getAll(_ entityType: EntityType.Type, _ entityDescription: NSEntityDescription) -> Result<[EntityType], Error>
    func update(_ entity: EntityType)
    func delete(_ entity: EntityType)
}
