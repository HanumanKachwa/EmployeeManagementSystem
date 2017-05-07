// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Address.swift instead.

import Foundation
import CoreData

public enum AddressAttributes: String {
    case addressLine1 = "addressLine1"
    case addressLine2 = "addressLine2"
    case country = "country"
    case pinCode = "pinCode"
    case state = "state"
    case timestamp = "timestamp"
}

open class _Address: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Address"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Address.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var addressLine1: String?

    @NSManaged open
    var addressLine2: String?

    @NSManaged open
    var country: String?

    @NSManaged open
    var pinCode: NSNumber?

    @NSManaged open
    var state: String?

    @NSManaged open
    var timestamp: Date?

    // MARK: - Relationships

}

