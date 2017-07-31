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
            let gameAtRow = game(atRow: indexPath.row)
            if hasCover(forId: gameAtRow.id) {
                gameCell.setup(cover: gameCover(byId: gameAtRow.id))
            } else {
                loadImageUsecase.load(id: gameAtRow.id, url: gameAtRow.coverUrl)
            }
            gameCell.setup(name: gameAtRow.name)
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

    func game(atRow row: Int) -> Game {
        return games[row]
    }

    func gameCover(byId id: Int) -> UIImage? {
        if let cover = gamesCovers[id] {
            return cover
        }
        return nil
    }

    private func hasCover(forId id: Int) -> Bool {
        return gamesCovers.keys.contains(id)
    }

}
