struct SaveTopGamesUseCase {

    private let saveGamesGateway: SaveGamesGateway
    private let allGamesGateway: AllGamesGateway
    private let saveGamesPresenter: SaveGamesPresenter
    private let cleanGamesGateway: CleanGamesGateway

    init(saveGamesGateway: SaveGamesGateway, allGamesGateway: AllGamesGateway, saveGamesPresenter: SaveGamesPresenter,
         cleanGamesGateway: CleanGamesGateway) {
        self.saveGamesGateway = saveGamesGateway
        self.allGamesGateway = allGamesGateway
        self.saveGamesPresenter = saveGamesPresenter
        self.cleanGamesGateway = cleanGamesGateway
    }

    func save() {
        allGamesGateway
            .allGames()
            .map({
                _ = self.cleanGamesGateway.clean()
                return $0
            })
            .flatMap(saveGamesGateway.save)
            .onResult({ result in
                switch result {
                case .success:
                    self.saveGamesPresenter.saved()
                case .fail(let error):
                    self.saveGamesPresenter.error(error: error)
                }
            })
    }

}
