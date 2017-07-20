import XCTest
import CoreData
@testable import PopGames

class AllGamesCoreDataGatewayTests: XCTestCase {

    private let gameName = "Counter Strike"
    private let gamePopularity = 10
    private let gameViewers = 20
    private var gateway: AllGamesCoreDataGateway!
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        context = NSManagedObjectContext.inMemory()
        gateway = AllGamesCoreDataGateway(managedObjectContext: context)
        create(game: GameEntity(name: gameName, popularity: gamePopularity, viewers: gameViewers))
    }

    func testAllGamesWhenHasGamesThenReturnGamesArray() {
        var games: [Game] = []

        gateway.allGames().onResult { if case Result<[Game]>.success(let requestedGames) = $0 {
            games = requestedGames
        }}

        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(games[0].name, gameName)
        XCTAssertEqual(games[0].popularity, gamePopularity)
        XCTAssertEqual(games[0].viewers, gameViewers)
    }

    private func create(game: Game) {
        let entityName = String(describing: GameEntityCoreData.self)
        let gameCoreData = NSEntityDescription.insertNewObject(forEntityName: entityName,
                                                               into: context) as? GameEntityCoreData

        gameCoreData?.id = 0
        gameCoreData?.name = game.name
        gameCoreData?.viewers = Int32(game.viewers)
        gameCoreData?.popularity = Int32(game.popularity)

        try? context.save()
    }
}
