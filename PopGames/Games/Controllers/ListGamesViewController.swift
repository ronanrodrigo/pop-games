import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet fileprivate weak var loadingView: LoadingView!
    @IBOutlet private weak var gamesCollectionView: UICollectionView!

    // swiftlint:disable:next weak_delegate
    private let collectionViewDelegate = GamesCollectionViewDelegate()
    private let collectionViewDataSource = GamesCollectionViewDataSource()

    private lazy var saveGamesPresenter: SaveGamesUIKitPresenter = {
        return SaveGamesUIKitPresenter(loadingView: self.loadingView)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataProviders()
        saveTopGames()
    }

    private func setupDataProviders() {
        gamesCollectionView.dataSource = collectionViewDataSource
        gamesCollectionView.delegate = collectionViewDelegate
    }

    private func saveTopGames() {
        SaveTopGamesUseCaseFactory.make(saveGamesPresenter: saveGamesPresenter).save()
    }

}
