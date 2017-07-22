import UIKit

class ListGamesViewController: UIViewController {

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
        print("saved")
    }

    func error(error: Error?) {
        print("error")
    }
}
