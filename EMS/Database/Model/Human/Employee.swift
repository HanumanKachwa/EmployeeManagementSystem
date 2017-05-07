import Foundation
import CoreData

enum CoreDataCustomErrorCodes: Int {
    case duplicateRecord = 801
    case unableToSaveData = 999
    
    var domain:String {
        switch self {
        case .duplicateRecord:
            return "Duplicate Data"
        case .unableToSaveData:
            return "Unable to save data"
        }
    }
}

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
    
    // check for duplicate employee record
    class func isDuplicate(email: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Bool {
        var isDuplicate = true
        
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        let predicate = NSPredicate(format: "email == %@",email)
        fetchRequest.predicate = predicate
        
        
        do {
            let duplicateCount = try managedObjectContext.count(for: fetchRequest)
            if duplicateCount == 0 {
                // insert employee since it is unique
                isDuplicate = false
            }
            else {
                // is duplicate
            }
        } catch {
            let error = error as NSError
            print("\(error), \(error.userInfo)")
        }
        
        return isDuplicate
    }
    
    // adding employee to local db
    class func addEmployee(_ employee: Employee) -> NSError? {
        var insertError : NSError? = nil
        let managedObjectContext = employee.managedObjectContext
        
        // Check if it is a duplicate entry
        if isDuplicate(email: employee.email, inManagedObjectContext: managedObjectContext!) {
            // is duplicate
            let userInfo = [NSLocalizedDescriptionKey :  NSLocalizedString("Duplicate Employee!", value: "Employee with same email already exists.", comment: "")]
            insertError = NSError(domain: CoreDataCustomErrorCodes.duplicateRecord.domain, code: CoreDataCustomErrorCodes.duplicateRecord.rawValue, userInfo: userInfo)
        }
        else {
            // email does not exist
            employee.timestamp = Date()
            employee.status = NSNumber(value: true)

            do {
                try managedObjectContext?.save()
            } catch {
                let error = error as NSError
                print("\(error), \(error.userInfo)")
                insertError = error
            }
        }
        
        return insertError
    }

    class func addEmployee(withEmail email: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> NSError? {
        var insertError : NSError? = nil
        // Check if it is a duplicate entry
        if isDuplicate(email: email, inManagedObjectContext: managedObjectContext) {
            // is duplicate
            let userInfo = [NSLocalizedDescriptionKey :  NSLocalizedString("Duplicate Employee!", value: "Employee with same email already exists.", comment: "")]
            insertError = NSError(domain: CoreDataCustomErrorCodes.duplicateRecord.domain, code: CoreDataCustomErrorCodes.duplicateRecord.rawValue, userInfo: userInfo)
        }
        else {
            // email does not exist
            let employee = Employee(context: managedObjectContext)
            employee.timestamp = Date()
            employee.email = email
            employee.status = NSNumber(value: true)
            employee.empID = Employee.getNextEmployeeId()

            do {
                try managedObjectContext.save()
            } catch {
                let error = error as NSError
                print("\(error), \(error.userInfo)")
                insertError = error
            }
        }
        
        return insertError
    }
    
    // retrieve employee
    class func getEmployee(withEmail email: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> Employee? {
        var employee: Employee?
        
        let fetchRequest: NSFetchRequest<Employee> = Employee.fetchRequest()
        let predicate = NSPredicate(format: "email = %@", email)
        fetchRequest.predicate = predicate
        
        do {
            let returnArray = try managedObjectContext.fetch(fetchRequest)
            if returnArray.count > 0 {
                employee = returnArray.last
            }
        } catch let error as NSError {
            print(error)
        } catch {
            print("Unknown error")
        }
        
        return employee
    }

}
