import UIKit

class GamesCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    private let cellIdentifier = "GameCollectionViewCell"

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }

}
