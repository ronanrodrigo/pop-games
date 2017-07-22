struct SaveGamesCoreDataGatewayFactory {

    static func make() -> SaveGamesGateway {
        let coreDataStack = CoreDataStack()
        return SaveGamesCoreDataGateway(managedObjectContext: coreDataStack.persistentContainer.viewContext)
    }

}
