import Foundation

struct TwitchTopGamesDecodable: Decodable {
    let top: [TopGameDecodable]
}

struct TopGameDecodable: Decodable {
    let game: GameDecodable
    let viewers: Int
}

struct GameDecodable: Decodable {
    let name: String
    let popularity: Int
    let box: Box
}

struct Box: Decodable {
    let large: URL
}
