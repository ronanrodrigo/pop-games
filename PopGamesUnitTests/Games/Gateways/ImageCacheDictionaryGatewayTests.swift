import Foundation
import XCTest
@testable import PopGames

class ImageCacheDictionaryGatewayTests: XCTestCase {

    private var imageCacheDictionaryGateway: ImageCacheDictionaryGateway!
    private let sampleId = 0
    private let sampleInvalidId = 666
    private let sampleData = Data(count: 666)

    override func setUp() {
        super.setUp()
        imageCacheDictionaryGateway = ImageCacheDictionaryGateway()
    }

    func testValueForKeyWhenHasKeyThenReturnValue() {
        imageCacheDictionaryGateway.cache(key: sampleId, value: sampleData)

        let cachedData = try? imageCacheDictionaryGateway.value(forKey: sampleId)

        XCTAssertEqual(cachedData?.count, 666)
    }

    func testValueForKeyWhenHasNotKeyThenThrowsException() {
        XCTAssertThrowsError(try imageCacheDictionaryGateway.value(forKey: sampleInvalidId))
    }

    func testExistCacheWhenHasValueAtKeyThanReturnTrue() {
        imageCacheDictionaryGateway.cache(key: sampleId, value: sampleData)

        let hasCache = imageCacheDictionaryGateway.existCache(forKey: sampleId)

        XCTAssertTrue(hasCache)
    }

    func testExistCacheWhenHasNotValueAtKeyThanReturnFalse() {
        let hasCache = imageCacheDictionaryGateway.existCache(forKey: sampleInvalidId)

        XCTAssertFalse(hasCache)
    }

}
