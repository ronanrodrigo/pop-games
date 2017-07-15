protocol Game {
    var name: String { get }
    var viewers: Int { get }
    var popularity: Int { get }
}

struct GameEntity: Game, Decodable {
    let name: String
    let viewers: Int
    let popularity: Int
}
