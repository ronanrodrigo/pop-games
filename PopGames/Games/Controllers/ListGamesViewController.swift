import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet fileprivate weak var loadingView: LoadingView!
    @IBOutlet private weak var gamesCollectionView: UICollectionView!

    // swiftlint:disable:next weak_delegate
    private let collectionViewDelegate = GamesCollectionViewDelegate()
    private let collectionViewDataSource = GamesCollectionViewDataSource()

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
        SaveTopGamesUseCaseFactory.make(saveGamesPresenter: self).save()
    }

}

extension ListGamesViewController: SaveGamesPresenter {

    func saved() {
        stopLoading()
    }

    func error(error: Error?) {
        stopLoading()
    }

    private func stopLoading() {
        DispatchQueue.main.async { [unowned self] in
            self.loadingView.stopLoading()
        }
    }
}
