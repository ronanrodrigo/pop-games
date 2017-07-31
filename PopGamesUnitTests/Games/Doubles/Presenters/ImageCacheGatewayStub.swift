import Foundation
@testable import PopGames

class ImageCacheGatewayStub: ImageCacheGateway {

    var setupExistCacheForKey: Bool!
    var setupValueForKey: Data!
    var setupValueForKeyError: Error?

    var didCallCacheKeyValue = false
    var didCallExistCacheForKey = false
    var valueForKeyStub = false

    func cache(key: Int, value: Data) {
        didCallCacheKeyValue = true
    }

    func existCache(forKey key: Int) -> Bool {
        didCallExistCacheForKey = true
        return setupExistCacheForKey
    }

    func value(forKey key: Int) throws -> Data {
        valueForKeyStub = true
        if let error = setupValueForKeyError { throw error }
        return setupValueForKey
    }
}
