//
//  CoreDataStack.swift
//  NickelFoxDemo
//
//  Created by Ruchin Somal on 31/12/18.
//  Copyright © 2018 Ruchin Somal. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    static let moduleName  = dataModelName
    static let sharedInstance = CoreDataStack()
    private override init() {}
    
    func saveContxt() {
        guard mainManagedObjectContext.hasChanges || privateManagedObjectContext.hasChanges else {
            return
        }
        mainManagedObjectContext.performAndWait {
            do {
                try self.mainManagedObjectContext.save()
                print("Data saved")
            } catch {
                fatalError("Error \(error)")
            }
        }
        privateManagedObjectContext.perform {
            do {
                try self.privateManagedObjectContext.save()
                print("Data saved")
            } catch {
                fatalError("Error \(error)")
            }
        }
    }
    
    private(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.parent = self.privateManagedObjectContext
        
        return managedObjectContext
    }()
    
    private lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: CoreDataStack.moduleName, withExtension: "momd") else {
            fatalError("Unable to Find Data Model")
        }
        
        // Initialize Managed Object Model
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to Load Data Model")
        }
        
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        // Helpers
        let fileManager = FileManager.default
        let storeName = "\(CoreDataStack.moduleName).sqlite"
        
        // URL Documents Directory
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // URL Persistent Store
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            // Add Persistent Store
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)
            
        } catch {
            fatalError("Unable to Add Persistent Store")
        }
        
        return persistentStoreCoordinator
    }()
}
