struct SaveTopGamesUseCase {

    private let saveGamesGateway: SaveGamesGateway
    private let allGamesGateway: AllGamesGateway
    private let saveGamesPresenter: SaveGamesPresenter

    init(saveGamesGateway: SaveGamesGateway, allGamesGateway: AllGamesGateway, saveGamesPresenter: SaveGamesPresenter) {
        self.saveGamesGateway = saveGamesGateway
        self.allGamesGateway = allGamesGateway
        self.saveGamesPresenter = saveGamesPresenter
    }

    func save() {
        allGamesGateway
            .allGames()
            .flatMap(saveGamesGateway.save)
            .onResult { result in
                switch result {
                case .success:
                    self.saveGamesPresenter.saved()
                case .fail(let error):
                    self.saveGamesPresenter.error(error: error)
                }
        }
    }

}
