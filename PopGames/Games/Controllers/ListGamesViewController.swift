import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet private weak var gamesCollectionView: UICollectionView!

    // swiftlint:disable weak_delegate
    private let collectionViewDelegate = GamesCollectionViewDelegate()
    private let collectionViewDataSource = GamesCollectionViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataProviders()
    }

    private func setupDataProviders() {
        gamesCollectionView.dataSource = collectionViewDataSource
        gamesCollectionView.delegate = collectionViewDelegate
    }

}
