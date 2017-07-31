struct TwitchTopGamesDecodable: Decodable {

    let top: [TopGameDecodable]

}

extension TwitchTopGamesDecodable {

    struct TopGameDecodable: Decodable {
        let game: GameDecodable
        let viewers: Int
    }

}

extension TwitchTopGamesDecodable.TopGameDecodable {

    struct GameDecodable: Decodable {
        let name: String
        let popularity: Int
        let id: Int
        let box: BoxDecodable

        enum CodingKeys: String, CodingKey {
            case id = "_id", popularity, name, box
        }
    }

}

extension TwitchTopGamesDecodable.TopGameDecodable.GameDecodable {

    struct BoxDecodable: Decodable {
        let large: String
    }

}
