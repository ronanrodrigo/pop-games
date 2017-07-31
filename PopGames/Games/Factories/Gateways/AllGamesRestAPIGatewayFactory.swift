import Foundation

struct AllGamesRestAPIGatewayFactory {

    static func make() -> AllGamesGateway {
        return AllGamesRestAPIGateway()
    }

}
