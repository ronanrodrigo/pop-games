import Foundation
@testable import PopGames

class AllGamesGatewayStub: AllGamesGateway {

    var allGamesStub = false
    var allGamesOnCompleteStub: Result<[Game]>!

    func allGames() -> Future<[Game]> {
        allGamesStub = true
        return Future { completion in
            completion(allGamesOnCompleteStub)
        }
    }
}
