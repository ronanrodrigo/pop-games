protocol Game {
    var id: Int { get }
    var coverUrl: String { get }
    var name: String { get }
    var popularity: Int { get }
    var viewers: Int { get }
}

struct GameEntity: Game {
    let id: Int
    let coverUrl: String
    let name: String
    let popularity: Int
    let viewers: Int
}
