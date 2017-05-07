//
//  EmployeeAddViewController.swift
//  EMS
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class EmployeeAddViewController: FormViewController {
    var employee = Employee(context: CoreDataStack.sharedStack.persistentContainer.viewContext)
    let imageStore = ImageStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        employee.empID = Employee.getNextEmployeeId()

        initializeForm()
    }
    
    private func initializeForm() {
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        }
        DateRow.defaultRowInitializer = { row in row.minimumDate = Date() }

        form +++
            EmailRow() {
                $0.title = "Email"
                $0.placeholder = "example@domain.com.au"
                $0.add(rule: RuleRequired())
                var ruleSet = RuleSet<String>()
                ruleSet.add(rule: RuleRequired())
                ruleSet.add(rule: RuleEmail())
                $0.add(ruleSet: ruleSet)
                $0.validationOptions = .validatesOnChangeAfterBlurred
                }.onChange { row in
                    self.employee.email = row.value!
            }
            <<< NameRow(){ row in
                row.title = "First Name"
                row.placeholder = "Enter name here"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }.onChange { row in
                self.employee.firstName = row.value
            }
            <<< NameRow(){ row in
                row.title = "Last Name"
                row.placeholder = "Enter name here"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.onChange { row in
                self.employee.lastName = row.value
            }
            <<< ImageRow(){
                $0.title = "Profile Picture"
                }.onChange { row in
                    print(row.value ?? "Profile Picture")
                    self.employee.profilePicture = String(format:"IMAGE_KEY_%d", (self.employee.empID?.intValue)!)
                    self.imageStore.setImage(row.value!, forKey:self.employee.profilePicture!)
            }
            <<< PhoneRow(){
                $0.title = "Phone"
                $0.placeholder = "Enter phone here"
                }.onChange { row in
                    self.employee.phoneNumber = row.value
            }
            <<< PushRow<Gender>("Gender") {
                $0.title = $0.tag
                $0.options = Gender.allValues
                $0.value = .none
                }.onPresent({ (_, vc) in
                    vc.enableDeselection = false
                    vc.dismissOnSelection = false
                }).onChange { row in
                    self.employee.gender = row.value.map { $0.rawValue }
            }
            <<< DateRow(){
                $0.title = "DOB"
                $0.value = Date(timeIntervalSinceNow: -100*365*24*60*60)
                let formatter = DateFormatter()
                formatter.locale = .current
                formatter.dateStyle = .short
                $0.dateFormatter = formatter
                }.onChange { row in
                    self.employee.dateOfBirth = row.value
        }
    }
    
    @IBAction func didTapCancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapSaveBtn(_ sender: Any) {
        if let error = Employee.addEmployee(employee) {
            displayAlert(withTitle: "Employee could not be added!", message: error.localizedDescription)
        }else {
            displayAlert(withTitle: "Info", message: "Employee added successfully", defaultButtonTitle: "OK", completion: { 
                self.dismiss(animated: true, completion: nil)
            })
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    typealias VoidParameterReturn = (() -> Void)
    func displayAlert(withTitle title: String = "", message: String = "", defaultButtonTitle: String = "OK", completion: VoidParameterReturn? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: defaultButtonTitle, style: .default) { (action:UIAlertAction!) -> Void in
            if let completion = completion {
                completion()
            }
        }
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: { })
    }
}

enum Gender : String, CustomStringConvertible {
    case Male = "Male"
    case Female = "Female"
    case None = "None"
    
    var description : String { return rawValue }
    
    static let allValues = [Male, Female, None]
}
