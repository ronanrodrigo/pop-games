import UIKit

struct AllGamesCoreDataGatewayFactory {

    static func make() -> AllGamesGateway {
        return AllGamesCoreDataGateway(managedObjectContext: ManagedObjectContextFactory.make())
    }

}
