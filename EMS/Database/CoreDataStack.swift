//
//  CoreDataStack.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    // Applications default directory address
    
    static let sharedStack = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EMS")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error._userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func saveObject(modalObject:NSManagedObject) {
        let context = modalObject.managedObjectContext
        if (context?.hasChanges)! {
            do {
                try context?.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }

    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // Optional
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performForegroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.perform {
            block(self.viewContext)
        }
    }
    
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.persistentContainer.performBackgroundTask(block)
    }
    
    /*
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    lazy var managedObjectModel: NSManagedObjectModel = {
        // 1
        let modelURL = Bundle.main.url(forResource: "SensoryAutomation", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SensoryAutomation.sqlite")
        do {
            // If your looking for any kind of migration then here is the time to pass it to the options
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch let  error as NSError {
            print("Ops there was an error \(error.localizedDescription)")
            abort()
        }
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }()
    // if there is any change in the context save it
    func saveContext() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                print("Ops there was an error \(error.localizedDescription)")
                abort() 
            }
        } 
    }
 */
}
