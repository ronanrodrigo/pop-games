import XCTest
@testable import PopGames

class TwitchDecodableTests: XCTestCase {

    private var topGameData: Data!
    private let firstGameId = 21779

    override func setUp() {
        super.setUp()
        topGameData = loadJson(fromFileName: "ListTopGamesSuccess")
    }

    func testDecodeTwitchEntityFromJsonWhenJsonAreEqualASuccessResponse() {
        let twitch: TwitchTopGamesDecodable = JSONDecoder().decode(data: topGameData)

        XCTAssertNotNil(twitch)
        XCTAssertEqual(twitch.top.count, 10)
        XCTAssertEqual(twitch.top.first?.game.id, firstGameId)
    }

}
