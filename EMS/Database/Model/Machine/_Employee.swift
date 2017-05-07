// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Employee.swift instead.

import Foundation
import CoreData

public enum EmployeeAttributes: String {
    case dateOfBirth = "dateOfBirth"
    case email = "email"
    case empID = "empID"
    case firstName = "firstName"
    case gender = "gender"
    case joiningDate = "joiningDate"
    case lastName = "lastName"
    case phoneNumber = "phoneNumber"
    case profilePicture = "profilePicture"
    case status = "status"
    case timestamp = "timestamp"
}

public enum EmployeeRelationships: String {
    case address = "address"
}

open class _Employee: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Employee"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Employee.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var dateOfBirth: Date?

    @NSManaged open
    var email: String?

    @NSManaged open
    var empID: NSNumber?

    @NSManaged open
    var firstName: String?

    @NSManaged open
    var gender: String?

    @NSManaged open
    var joiningDate: Date?

    @NSManaged open
    var lastName: String?

    @NSManaged open
    var phoneNumber: String?

    @NSManaged open
    var profilePicture: String?

    @NSManaged open
    var status: NSNumber?

    @NSManaged open
    var timestamp: Date?

    // MARK: - Relationships

    @NSManaged open
    var address: Employee?

}

