import Foundation

struct AllGamesRestAPIGateway: AllGamesGateway {

    func allGames() -> Future<[Game]> {
        var request = URLRequest(url: URL.Twitch.topGame)
        request.httpMethod = String.HttpMetod.get
        request.addValue(String.Twitch.Header.clientId, forHTTPHeaderField: String.clientId)
        request.addValue(String.Twitch.Header.accept, forHTTPHeaderField: String.accept)

        return Future { completion in
            URLSession.shared.dataTask(
                with: request,
                completionHandler: { (data: Data?, _, error: Error?) -> Void in
                    completion(self.generateResult(data: data, error: error))
                }).resume()
            URLSession.shared.finishTasksAndInvalidate()
        }
    }

    private func generateResult(data: Data?, error: Error?) -> Result<[Game]> {
        if error == nil, let data = data {
            var twitchTopGames: TwitchTopGamesDecodable
            do {
                twitchTopGames = try JSONDecoder().decode(TwitchTopGamesDecodable.self, from: data)
            } catch let error { return Result.fail(error) }

            let games = generateGameEntity(twitchTopGames: twitchTopGames)
            return Result.success(games)
        } else if data == nil {
            return Result.fail(PopGamesError.noResponse)
        }

        return Result.fail(error)
    }

    private func generateGameEntity(twitchTopGames: TwitchTopGamesDecodable) -> [Game] {
        let games = twitchTopGames.top.map { topGame -> Game in
            return GameEntity(id: topGame.game.id, coverUrl: topGame.game.box.large, name: topGame.game.name,
                              popularity: topGame.game.popularity, viewers: topGame.viewers)
        }
        return games
    }

}
