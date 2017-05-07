import Foundation
import CoreData

@objc(Employee)
open class Employee: _Employee {
	// Custom logic goes here.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee");
    }
}
