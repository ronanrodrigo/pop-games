import Foundation

protocol ImageCacheGateway {
    func existCache(forKey key: Int) -> Bool
    func cache(key: Int, value: Data)
    func value(forKey key: Int) throws -> Data
}
