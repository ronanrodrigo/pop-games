protocol AllGamesGateway {
    func allGames() -> Future<[Game]>
}
