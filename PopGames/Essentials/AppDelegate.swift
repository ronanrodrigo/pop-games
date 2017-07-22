import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var coreDataStack: CoreDataStack = CoreDataStack()

    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

}
