import Foundation

class ImageCacheDictionaryGateway: ImageCacheGateway {

    private var cachedImages: [Int: Data] = [:]

    func cache(key: Int, value: Data) {
        cachedImages[key] = value
    }

    func existCache(forKey key: Int) -> Bool {
        return cachedImages.keys.contains(key)
    }

    func value(forKey key: Int) throws -> Data {
        guard let data = cachedImages[key] else { throw ImageCacheError.notFound }
        return data
    }

}
