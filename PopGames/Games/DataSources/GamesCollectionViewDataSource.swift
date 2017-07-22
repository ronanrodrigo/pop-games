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
        cell.backgroundColor = UIColor.red
        return cell
    }

    func update(games: [Game]) {
        self.games = games
    }

}
