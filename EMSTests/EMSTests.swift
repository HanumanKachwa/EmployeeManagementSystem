//
//  EMSTests.swift
//  EMSTests
//
//  Created by Hanuman on 07/05/17.
//  Copyright © 2017 Hanuman. All rights reserved.
//

import XCTest
import CoreData
@testable import EMS

class EMSTests: XCTestCase {
    var managedObjectContext: NSManagedObjectContext?
    let email = "hanuman.pr@gmail.com"
//    let firstName = "Hanuman"
//    let lastName = "Kachwa"
//    let phoneNumber = "0451479773"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if managedObjectContext == nil {
            managedObjectContext = setUpInMemoryManagedObjectContext()
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
//    //MARK:- fileprivate functions
//    fileprivate func getEmployee() -> Employee {
//        // create employee
//        let employee = Employee(context: managedObjectContext!)
//        employee.email = email
//        employee.firstName = firstName
//        employee.lastName = lastName
//        employee.phoneNumber = phoneNumber
//        
//        return employee
//    }

    func testAddEmployee() {
        // create employee
        let error = Employee.addEmployee(withEmail: "user1@gmail.com", inManagedObjectContext: managedObjectContext!)
        XCTAssertNil(error, "Employee adding failed")
    }
    
    func testGetEmployee() {
        // add a employee
        let email = "user2@gmail.com"
        let error = Employee.addEmployee(withEmail: email, inManagedObjectContext: managedObjectContext!)
        XCTAssertNil(error, "Employee adding failed")
        
        // retrieve added employee
        let nurse = Employee.getEmployee(withEmail: email, inManagedObjectContext: managedObjectContext!)
        XCTAssertNotNil(nurse, "Added employee record should be able to be retrieved")
    }

    func testIsEmployeeDuplicate() {
        // add a employee
        let email = "user3@gmail.com"
        let error = Employee.addEmployee(withEmail: email, inManagedObjectContext: managedObjectContext!)
        XCTAssertNil(error, "Employee adding failed")
        
        // query to see if the new Employee email already exists
        let isDuplicate = Employee.isDuplicate(email: email, inManagedObjectContext: managedObjectContext!)
        
        // assert
        XCTAssertTrue(isDuplicate, "Duplicate Employee should be identified")
    }

    func testIsNotDuplicate() {
        // search for email which does not exist
        let isDuplicate = Employee.isDuplicate(email: email, inManagedObjectContext: managedObjectContext!)
        
        // assert
        XCTAssertFalse(isDuplicate, "Email queried for a Employee which does not exist in local db should return false")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
