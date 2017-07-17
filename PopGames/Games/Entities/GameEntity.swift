protocol Game {
    var name: String { get }
    var popularity: Int { get }
    var viewers: Int { get }
}

struct GameEntity: Game {
    let name: String
    let popularity: Int
    let viewers: Int
}
