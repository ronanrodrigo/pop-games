@testable import PopGames

class SaveGamesPresenterStub: SaveGamesPresenter {

    var savedStub = false
    var errorStub = false

    func saved() {
        savedStub = true
    }

    func show(error: Error?) {
        errorStub = true
    }

}
