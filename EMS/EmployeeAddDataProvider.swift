//
//  EmployeeAddDataProvider.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import Foundation

open class EmployeeAddDataProvider: NSObject {
    
    open func addEmployee(_ employee: Employee) {
        let context = employee.managedObjectContext
        employee.timestamp = Date()
        employee.status = NSNumber(value: true)

        // Save the context.
        do {
            try context?.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
}

