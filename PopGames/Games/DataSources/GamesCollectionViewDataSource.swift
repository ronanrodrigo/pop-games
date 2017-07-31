import UIKit

class GamesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private var games: [Game] = []
    private var gamesCovers: [Int: UIImage?] = [:]
    private let loadImageUsecase: LoadImageUsecase

    init(loadImageUsecase: LoadImageUsecase) {
        self.loadImageUsecase = loadImageUsecase
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.Identifier.gamesCollection,
                                                      for: indexPath)

        if let gameCell = cell as? GameCollectionViewCell {
            let game = games[indexPath.row]
            if hasCover(forId: game.id) {
                gameCell.setup(cover: gameCover(byId: game.id))
            } else {
                loadImageUsecase.load(id: game.id, url: game.coverUrl)
            }
            gameCell.setup(name: game.name)
        }

        return cell
    }

    func update(games: [Game]) {
        self.games = games
    }

    func updateGameCover(withId id: Int, image: UIImage?) {
        self.gamesCovers[id] = image
    }

    func index(ofId id: Int) -> Int? {
        return games.index { $0.id == id }
    }

    private func hasCover(forId id: Int) -> Bool {
        return gamesCovers.keys.contains(id)
    }

    private func gameCover(byId id: Int) -> UIImage? {
        if let cover = gamesCovers[id] {
            return cover
        }
        return nil
    }

}
