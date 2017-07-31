import Foundation
@testable import PopGames

class LoadImageGatewayStub: LoadImageGateway {

    var didCallLoadUrl = false
    var setupLoadResult: Result<Data>!

    func load(url: String) -> Future<Data> {
        didCallLoadUrl = true
        return Future { completion in
            completion(setupLoadResult)
        }
    }

}
