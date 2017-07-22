import UIKit

struct SaveGamesCoreDataGatewayFactory {

    static func make() -> SaveGamesGateway {
        return SaveGamesCoreDataGateway(managedObjectContext: ManagedObjectContextFactory.make())
    }

}
