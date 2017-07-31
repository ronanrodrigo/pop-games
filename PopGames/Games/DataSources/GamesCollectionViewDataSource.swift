import UIKit

class GamesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private var games: [Game] = []
    private var gamesCovers: [Int: UIImage] = [:]
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
            loadImageUsecase.load(id: game.id, url: game.coverUrl)
            gameCell.setup(name: game.name)
            gameCell.setup(cover: gameCover(byId: game.id))
        }

        return cell
    }

    func update(games: [Game]) {
        self.games = games
    }

    func updateGameCover(withId id: Int, image: UIImage) {
        self.gamesCovers[id] = image
    }

    func index(ofId id: Int) -> Int? {
        return games.index { $0.id == id }
    }

    private func gameCover(byId id: Int) -> UIImage {
        if let gameCoverAtId = gamesCovers[id] {
            return gameCoverAtId
        }
        return #imageLiteral(resourceName: "Counter-Strike")
    }

}
