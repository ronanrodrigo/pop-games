import UIKit

struct AllGamesCoreDataGatewayFactory {

    static func make() -> AllGamesCoreDataGateway {
        let coreDataStack: CoreDataStack = CoreDataStack()
        return AllGamesCoreDataGateway(managedObjectContext: coreDataStack.persistentContainer.viewContext)
    }

}
