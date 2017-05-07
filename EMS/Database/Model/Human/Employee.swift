import Foundation
import CoreData

@objc(Employee)
open class Employee: _Employee {
	// Custom logic goes here.
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee");
    }
    
    @nonobjc public class func fetchAllActiveEmployeesRequest() -> NSFetchRequest<Employee> {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee");
        fetchRequest.predicate = NSPredicate(format: "status == %d", 1)
        return fetchRequest
    }

    @nonobjc public class func getNextEmployeeId() -> NSNumber {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee");
        let idDescriptor: NSSortDescriptor = NSSortDescriptor(key: "empID", ascending: false)
        fetchRequest.sortDescriptors = [idDescriptor]
        fetchRequest.fetchLimit = 1

        var newId = 0
        
        do {
            let results = try CoreDataStack.sharedStack.persistentContainer.viewContext.fetch(fetchRequest)

            if(results.count == 1) {
              newId = (results[0].empID?.intValue)! + 1
            } else {
                newId = 1
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

        return NSNumber(value: newId)
    }

    func employeeName() -> String {
        return String(format:"%@ %@", firstName!, lastName!)
    }
}
