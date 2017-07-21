import UIKit

struct AllGamesCoreDataGatewayFactory {

    static func make() -> AllGamesGateway {
        let coreDataStack: CoreDataStack = CoreDataStack()
        return AllGamesCoreDataGateway(managedObjectContext: coreDataStack.persistentContainer.viewContext)
    }

}
