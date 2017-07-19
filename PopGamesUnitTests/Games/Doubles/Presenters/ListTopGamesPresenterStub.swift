@testable import PopGames

class ListTopGamesPresenterStub: ListTopGamesPresenter {

    var listGamesStub = false
    var showErrorStub = false

    func list(games: [Game]) {
        listGamesStub = true
    }

    func show(error: Error) {
        showErrorStub = true
    }

}
