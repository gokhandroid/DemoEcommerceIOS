//
//  DemoCoreDataHelper.swift
//  DemoDBFramework
//
//  Created by Gökhan Ünal on 14.04.2023.
//

import Foundation
import CoreData

public class DemoCoreDataHelper : DemoCoreDataProtocol {
    
    public static let shared = DemoCoreDataHelper()
    
    public typealias EntityType = NSManagedObject
    public typealias PredicateType = NSPredicate
    private var dbName: String = ""
    
    public var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    public func setDbName(dbName: String) {
        self.dbName = dbName
    }
    
    init() {
        
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        if(dbName == ""){
            fatalError("DbName doesnt must empty")
        }
        
        let container = NSPersistentContainer(name: dbName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    
    public func create(_ entity: NSManagedObject) {
        do {
            try context.save()
        } catch let error as NSError {
                print("Error: \(error), \(error.userInfo)")
        }

    }
    
    public func getAll<T: NSManagedObject>(_ entityType: T.Type, _ entityDescription: NSEntityDescription) -> Result<[T], Error> {
        
        let request = entityType.fetchRequest()
        request.entity = entityDescription
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    public func get<T: NSManagedObject>(_ entityType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {

        let request = entityType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }
    
    public func update(_ entity: NSManagedObject) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func delete(_ entity: NSManagedObject) {
        context.delete(entity)
    }
    
}
