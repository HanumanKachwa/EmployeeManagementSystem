//
//  EmployeeListDataProviderProtocol.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public protocol EmployeeListDataProviderProtocol: UITableViewDataSource {
    var managedObjectContext: NSManagedObjectContext? { get set }
    weak var tableView: UITableView! { get set }
    
    func addEmployee(_ employee: Employee)
}
