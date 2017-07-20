import CoreData

struct AllGamesCoreDataGateway: AllGamesGateway {

    private let persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func allGames(onComplete: ((Result<[Game]>) -> Void)) {
        let fetchGames: NSFetchRequest<GameEntityCoreData> = GameEntityCoreData.fetchRequest()

        do {
            let games = try persistentContainer.viewContext.fetch(fetchGames)
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
