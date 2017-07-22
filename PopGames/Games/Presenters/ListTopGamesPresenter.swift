protocol ListTopGamesPresenter {
    func list(games: [Game])
    func show(error: Error?)
}
