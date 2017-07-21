import CoreData

struct SaveGamesCoreDataGateway: SaveGamesGateway {

    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func save(games: [Game]) -> Future<Void> {

        return Future { completion in
            let entityName = String(describing: GameEntityCoreData.self)
            for game in games {
                let gameCoreData = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                                       into: managedObjectContext) as? GameEntityCoreData
                gameCoreData?.name = game.name
                gameCoreData?.popularity = Int32(game.popularity)
                gameCoreData?.viewers = Int32(game.viewers)
            }
            do {
                try managedObjectContext.save()
                completion(Result.success(()))
            } catch {
                completion(Result.fail(error))
            }
        }
    }

}

