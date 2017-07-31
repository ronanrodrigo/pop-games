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
                var gameCoreData: GameEntityCoreData?
                DispatchQueue.main.async {
                    gameCoreData = NSEntityDescription.insertNewObject(
                        forEntityName: entityName,
                        into: self.managedObjectContext) as? GameEntityCoreData
                    gameCoreData?.id = Int32(game.id)
                    gameCoreData?.coverUrl = game.coverUrl
                    gameCoreData?.name = game.name
                    gameCoreData?.popularity = Int32(game.popularity)
                    gameCoreData?.viewers = Int32(game.viewers)
                }
            }
            DispatchQueue.main.async {
                completion(self.generateResult())
            }
        }
    }

    private func generateResult() -> Result<Void> {
        do {
            try managedObjectContext.save()
            return Result.success(())
        } catch {
            return Result.fail(error)
        }
    }

}
