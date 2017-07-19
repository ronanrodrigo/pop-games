import Foundation
@testable import PopGames

class AllGamesGatewayStub: AllGamesGateway {

    var allGamesStub = false
    var allGamesOnCompleteStub: Result<[Game]>!

    func allGames(onComplete: ((Result<[Game]>) -> Void)) {
        allGamesStub = true
        onComplete(allGamesOnCompleteStub)
    }

}
