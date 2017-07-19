import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private lazy var coreDataStack: CoreDataStack = CoreDataStack()
    var window: UIWindow?

    lazy var persistentContainer: NSPersistentContainer = {
        return self.coreDataStack.persistentContainer
    }()

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

}
