struct CleanGamesCoreDataGatewayFactory {

    static func make() -> CleanGamesGateway {
        return CleanGamesCoreDataGateway(managedObjectContext: ManagedObjectContextFactory.make())
    }

}
