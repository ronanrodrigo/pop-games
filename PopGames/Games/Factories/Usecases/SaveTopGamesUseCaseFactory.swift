struct SaveTopGamesUseCaseFactory {

    static func make(saveGamesPresenter: SaveGamesPresenter) -> SaveTopGamesUseCase {
        let saveGamesGateway = SaveGamesCoreDataGatewayFactory.make()
        let allGamesGateway = AllGamesRestAPIGatewayFactory.make()
        let cleanGamesGateway = CleanGamesCoreDataGatewayFactory.make()

        return SaveTopGamesUseCase(saveGamesGateway: saveGamesGateway, allGamesGateway: allGamesGateway,
                                   saveGamesPresenter: saveGamesPresenter, cleanGamesGateway: cleanGamesGateway)
    }

}
