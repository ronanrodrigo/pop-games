import Foundation
@testable import PopGames

class LoadImagePresenterStub: LoadImagePresenter {

    var didCallShowStub = false
    var didShowErrorStub = false

    func show(data: Data, forId id: Int) {
        didCallShowStub = true
    }

    func show(error: Error?) {
        didShowErrorStub = true
    }

}
