import XCTest
import CoreData
@testable import PopGames

class SaveGamesCoreDataGatewayTests: XCTestCase {

    private let gameName = "Counter Strike"
    private let gamePopularity = 10
    private let gameViewers = 20
    private var allGamesCoreDataGateway: AllGamesCoreDataGateway!
    private var saveGamesCoreDataGateway: SaveGamesCoreDataGateway!
    private var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        context = NSManagedObjectContext.inMemory()
        saveGamesCoreDataGateway = SaveGamesCoreDataGateway(managedObjectContext: context)
        allGamesCoreDataGateway = AllGamesCoreDataGateway(managedObjectContext: context)
    }

    func testSaveGamesWhenSuccessThenSaveGames() {
        let gamesToSave: [Game] = [GameEntity(name: gameName, popularity: gamePopularity, viewers: gameViewers),
                                   GameEntity(name: gameName, popularity: gamePopularity, viewers: gameViewers)]
        var savedGames: [Game] = []

        saveGamesCoreDataGateway.save(games: gamesToSave).flatMap(allGamesCoreDataGateway.allGames).onResult {
            if case Result<[Game]>.success(let requestedGames) = $0 {
                savedGames = requestedGames
            }
        }

        XCTAssertEqual(savedGames.count, gamesToSave.count)
        XCTAssertEqual(savedGames[0].name, gameName)
        XCTAssertEqual(savedGames[0].popularity, gamePopularity)
        XCTAssertEqual(savedGames[0].viewers, gameViewers)
    }
}
