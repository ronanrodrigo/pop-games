struct ListTopGamesUseCase {

    private let listTopGamesPresenter: ListTopGamesPresenter
    private let allGamesGateway: AllGamesGateway

    init(listTopGamesPresenter: ListTopGamesPresenter, allGamesGateway: AllGamesGateway) {
        self.listTopGamesPresenter = listTopGamesPresenter
        self.allGamesGateway = allGamesGateway
    }

    func list() {
        allGamesGateway.allGames().onResult { result in
            switch result {
            case .success(let games): self.listTopGamesPresenter.list(games: games)
            case .fail(let error): self.listTopGamesPresenter.show(error: error)
            }
        }
    }

}
