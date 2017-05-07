//
//  EmployeeDetailViewController.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.employeeName()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Employee? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

