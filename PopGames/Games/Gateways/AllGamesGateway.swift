protocol AllGamesGateway {
    func allGames(onComplete: ((Result<[Game]>) -> Void))
}
