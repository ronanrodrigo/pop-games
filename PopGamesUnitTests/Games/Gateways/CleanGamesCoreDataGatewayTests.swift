import XCTest
import CoreData
@testable import PopGames

class CleanGamesCoreDataGatewayTests: XCTestCase {

    private let game: Game = GameEntity(id: 0, coverUrl: "", name: "Counter Strike", popularity: 10, viewers: 10)
    private var cleanGamesCoreDataGateway: CleanGamesGateway!
    private var allGamesCoreDataGateway: AllGamesGateway!

    override func setUp() {
        super.setUp()
        cleanGamesCoreDataGateway = CleanGamesCoreDataGatewayFactory.make()
        allGamesCoreDataGateway = AllGamesCoreDataGatewayFactory.make()
        _ = SaveGamesCoreDataGatewayFactory.make().save(games: [game])
    }

    func testCleanGamesWhenSuccessThenHadNoGames() {
        var existingGames = [game]

        cleanGamesCoreDataGateway.clean().flatMap(allGamesCoreDataGateway.allGames).onResult {
            if case Result<[Game]>.success(let requestedGames) = $0 {
                existingGames = requestedGames
            }
        }

        XCTAssertEqual(existingGames.count, 0)
    }
}
