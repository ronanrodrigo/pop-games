protocol SaveGamesGateway {
    func save(games: [Game]) -> Future<Void>
}
