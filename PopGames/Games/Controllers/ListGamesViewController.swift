import UIKit

private typealias GamesDataProvider = (dataSource: GamesCollectionViewDataSource, delegate: GamesCollectionViewDelegate)

class ListGamesViewController: UIViewController {

    @IBOutlet private weak var gamesCollectionView: UICollectionView!
    private let gamesDataProvider: GamesDataProvider = (GamesCollectionViewDataSource(), GamesCollectionViewDelegate())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataProviders()
    }

    private func setupDataProviders() {
        gamesCollectionView.dataSource = gamesDataProvider.dataSource
        gamesCollectionView.delegate = gamesDataProvider.delegate
    }

}
