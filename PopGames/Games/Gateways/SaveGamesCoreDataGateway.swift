import CoreData

struct SaveGamesCoreDataGateway: SaveGamesGateway {

    private let privateManagedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext.parent = managedObjectContext
    }

    func save(games: [Game]) -> Future<Void> {

        return Future { completion in
            let entityName = String(describing: GameEntityCoreData.self)
            for game in games {
                var gameCoreData: GameEntityCoreData?
                gameCoreData = NSEntityDescription.insertNewObject(
                    forEntityName: entityName,
                    into: self.privateManagedObjectContext) as? GameEntityCoreData
                gameCoreData?.id = Int32(game.id)
                gameCoreData?.coverUrl = game.coverUrl
                gameCoreData?.name = game.name
                gameCoreData?.popularity = Int32(game.popularity)
                gameCoreData?.viewers = Int32(game.viewers)
            }
            completion(self.generateResult())
        }
    }

    private func generateResult() -> Result<Void> {
        do {
            try privateManagedObjectContext.save()
            return Result.success(())
        } catch {
            return Result.fail(error)
        }
    }

}
