import UIKit
import CoreData

struct ManagedObjectContextFactory {

    static func make() -> NSManagedObjectContext {
        let application = UIApplication.shared.delegate as! AppDelegate // swiftlint:disable:this force_cast
        return application.coreDataStack.persistentContainer.viewContext
    }

}
