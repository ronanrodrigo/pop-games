import UIKit

class GamesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private var games: [Game] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.Identifier.gamesCollection,
                                                      for: indexPath)

        if let gameCell = cell as? GameCollectionViewCell {
            gameCell.setup(name: games[indexPath.row].name)
        }

        return cell
    }

    func update(games: [Game]) {
        self.games = games
    }

}
