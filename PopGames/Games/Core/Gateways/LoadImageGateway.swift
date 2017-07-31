import Foundation

protocol LoadImageGateway {
    func load(url: String) -> Future<Data>
}
