import CoreData

struct AllGamesCoreDataGateway: AllGamesGateway {

    private let managedObjectContext: NSManagedObjectContext

    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }

    func allGames(onComplete: ((Result<[Game]>) -> Void)) {
        let fetchGames: NSFetchRequest<GameEntityCoreData> = GameEntityCoreData.fetchRequest()

        do {
            let games = try managedObjectContext.fetch(fetchGames)
            let gamesEntities = games.map(generateEntity)
            onComplete(Result.success(gamesEntities))
        } catch {
            onComplete(Result.fail(error))
        }
    }

    private func generateEntity(game: GameEntityCoreData) -> Game {
        return GameEntity(name: game.name ?? String.empty,
                          popularity: game.popularity.int,
                          viewers: game.viewers.int)
    }
}
