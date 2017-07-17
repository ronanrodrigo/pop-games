import XCTest
@testable import PopGames

class TwitchDecodableTests: XCTestCase {

    private var topGameData: Data!

    override func setUp() {
        super.setUp()
        topGameData = loadJson(fromFileName: "ListTopGamesSuccess")
    }

    func testDecodeTwitchEntityFromJsonWhenJsonAreEqualASuccessResponse() {
        let twitch: TwitchDecodable = JSONDecoder().decode(data: topGameData)

        XCTAssertNotNil(twitch)
        XCTAssertEqual(twitch.top.count, 10)
    }

}
