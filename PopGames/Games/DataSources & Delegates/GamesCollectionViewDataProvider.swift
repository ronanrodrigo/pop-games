import UIKit

class GamesCollectionViewDataProvider: NSObject {

    private var games: [Game] = []
    private var gamesCovers: [Int: UIImage?] = [:]
    private let loadImageUsecase: LoadImageUsecase
    private var didSelectGame: ((Game, UIImage?) -> Void)

    init(loadImageUsecase: LoadImageUsecase, didSelectGame: @escaping ((Game, UIImage?) -> Void)) {
        self.loadImageUsecase = loadImageUsecase
        self.didSelectGame = didSelectGame
    }

    func update(with games: [Game]) {
        self.games = games
    }

    func updateGameCover(id: Int, image: UIImage?) {
        self.gamesCovers[id] = image
    }

    func row(ofId id: Int) -> Int? {
        return games.index { $0.id == id }
    }

    private func game(atRow row: Int) -> Game {
        return games[row]
    }

    private func gameCover(byId id: Int) -> UIImage? {
        guard let cover = gamesCovers[id] else { return nil }
        return cover
    }

    private func hasCover(forId id: Int) -> Bool {
        return gamesCovers.keys.contains(id)
    }

}

extension GamesCollectionViewDataProvider: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.Identifier.gamesCollection,
                                                      for: indexPath)

        if let gameCell = cell as? GameCollectionViewCell {
            let game = self.game(atRow: indexPath.row)
            if hasCover(forId: game.id) {
                gameCell.setup(cover: gameCover(byId: game.id))
            } else {
                loadImageUsecase.load(id: game.id, url: game.coverUrl)
            }
            gameCell.setup(name: game.name)
        }

        return cell
    }

}

extension GamesCollectionViewDataProvider: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 25
        let collectionCellSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionCellSize/2, height: collectionCellSize/2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = self.game(atRow: indexPath.row)
        didSelectGame(game, gameCover(byId: game.id))
    }

}
