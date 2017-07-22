struct ListTopGamesUseCaseFactory {

    static func make(presenter: ListTopGamesPresenter) -> ListTopGamesUseCase {
        let gateway = AllGamesCoreDataGatewayFactory.make()
        return ListTopGamesUseCase(listTopGamesPresenter: presenter, allGamesGateway: gateway)
    }
}
