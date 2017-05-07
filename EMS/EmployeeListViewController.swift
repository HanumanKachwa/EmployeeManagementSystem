//
//  EmployeeListViewController.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import UIKit
import CoreData

class EmployeeListViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var dataProvider: EmployeeListDataProviderProtocol?
    var detailViewController: EmployeeDetailViewController? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? EmployeeDetailViewController
        }

        assert(dataProvider != nil, "dataProvider is not allowed to be nil at this point")
        tableView.dataSource = dataProvider
        dataProvider?.tableView = tableView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let employee = dataProvider?.getSelectedEmployee() {
                let controller = (segue.destination as! UINavigationController).topViewController as! EmployeeDetailViewController
                controller.detailItem = employee
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
