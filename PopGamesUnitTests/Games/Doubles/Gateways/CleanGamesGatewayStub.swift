@testable import PopGames

class CleanGamesGatewayStub: CleanGamesGateway {

    var cleanStub = false
    var cleanGameOnCompleteStub: Result<Void>!

    func clean() -> Future<Void> {
        cleanStub = true
        return Future { completion in
            completion(cleanGameOnCompleteStub)
        }
    }

}
