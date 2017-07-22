@testable import PopGames

class SaveGamesPresenterStub: SaveGamesPresenter {

    var savedStub = false
    var errorStub = false

    func saved() {
        savedStub = true
    }

    func error(error: Error?) {
        errorStub = true
    }

}
