struct ListTopGamesUseCase {

    private let presenter: ListTopGamesPresenter
    private let gateway: AllGamesGateway

    init(presenter: ListTopGamesPresenter, allGamesGateway: AllGamesGateway) {
        self.presenter = presenter
        self.gateway = allGamesGateway
    }

    func list() {
        gateway.allGames().onResult { result in
            switch result {
            case .success(let games): self.presenter.list(games: games)
            case .fail(let error): self.presenter.show(error: error)
            }
        }
    }

}
