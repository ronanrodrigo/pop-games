import UIKit

class ListGamesView: NibLoadableView {

    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet fileprivate weak var loadingView: LoadingView!

    // swiftlint:disable:next weak_delegate
    private let collectionViewDelegate = GamesCollectionViewDelegate()
    private lazy var collectionViewDataSource = {
        return GamesCollectionViewDataSource(loadImageUsecase: LoadImageUsecaseFactory.make(presenter: self))
    }()

    var listTopGamesPresenter: ListTopGamesPresenter { return self }
    var saveGamesPresenter: SaveGamesPresenter { return self }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.dataSource = collectionViewDataSource
        collectionView.delegate = collectionViewDelegate

        let nib = UINib(nibName: String(describing: GameCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: String.Identifier.gamesCollection)
    }

    func show(error: Error?) {
        loadingView.stopLoading()
    }
}

extension ListGamesView: ListTopGamesPresenter {

    func list(games: [Game]) {
        collectionViewDataSource.update(games: games)
        collectionView.reloadData()
        loadingView.stopLoading()
    }

}

extension ListGamesView: SaveGamesPresenter {

    func saved() {
        DispatchQueue.main.async { NotificationCenter.default.post(Notification.Game.didSaveGames) }
    }

}

extension ListGamesView: LoadImagePresenter {

    func show(data: Data, forId id: Int) {
        let image = UIImage(data: data) ?? #imageLiteral(resourceName: "Counter-Strike")
        collectionViewDataSource.updateGameCover(withId: id, image: image)

        if let row = self.collectionViewDataSource.index(ofId: id) {
            let intedPathToUpdate = IndexPath(row: row, section: 0)
            DispatchQueue.main.async { [unowned self] in
                self.collectionView.reloadItems(at: [intedPathToUpdate])
            }
        }
    }

}
