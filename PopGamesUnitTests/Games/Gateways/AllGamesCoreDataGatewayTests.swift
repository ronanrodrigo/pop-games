import XCTest
import CoreData
@testable import PopGames

class AllGamesCoreDataGatewayTests: XCTestCase {

    private let gameName = "Counter Strike"
    private let gamePopularity = 10
    private let gameViewers = 20
    private let gameCoverUrl = "http://www.com.br"
    private let gameId = 666
    private var gateway: AllGamesCoreDataGateway!
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        context = NSManagedObjectContext.inMemory()
        gateway = AllGamesCoreDataGateway(managedObjectContext: context)
        let game = GameEntity(id: gameId, coverUrl: gameCoverUrl, name: gameName, popularity: gamePopularity,
                              viewers: gameViewers)
        _ = SaveGamesCoreDataGateway(managedObjectContext: context).save(games: [game])
    }

    func testAllGamesWhenHasGamesThenReturnGamesArray() {
        var games: [Game] = []

        gateway.allGames().onResult { if case Result<[Game]>.success(let requestedGames) = $0 {
            games = requestedGames
        }}

        XCTAssertEqual(games.count, 1)
        XCTAssertEqual(games[0].id, gameId)
        XCTAssertEqual(games[0].coverUrl, gameCoverUrl)
        XCTAssertEqual(games[0].popularity, gamePopularity)
        XCTAssertEqual(games[0].viewers, gameViewers)
    }

}
