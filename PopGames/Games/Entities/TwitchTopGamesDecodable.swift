struct TwitchTopGamesDecodable: Decodable {
    let top: [TopGameDecodable]

    struct TopGameDecodable: Decodable {
        let game: GameDecodable
        let viewers: Int

        struct GameDecodable: Decodable {
            let name: String
            let popularity: Int
        }
    }
}
