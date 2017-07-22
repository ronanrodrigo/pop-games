@testable import PopGames

class SaveGamesGatewayStub: SaveGamesGateway {

    var saveStub = false
    var saveGameOnCompleteStub: Result<Void>!

    func save(games: [Game]) -> Future<Void> {
        saveStub = true
        return Future { completion in
            completion(saveGameOnCompleteStub)
        }
    }

}
