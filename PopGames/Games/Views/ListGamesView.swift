import UIKit

class ListGamesView: NibLoadableView {

    @IBOutlet private weak var loadingView: LoadingView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: String(describing: GameCollectionViewCell.self), bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: String.Identifier.gamesCollection)
        }
    }

    private var camesCollectionViewDataProvider: GamesCollectionViewDataProvider! {
        didSet {
            collectionView.dataSource = camesCollectionViewDataProvider
            collectionView.delegate = camesCollectionViewDataProvider
        }
    }

    var listTopGamesPresenter: ListTopGamesPresenter { return self }
    var saveGamesPresenter: SaveGamesPresenter { return self }
    var loadImagePresenter: LoadImagePresenter { return self }

    func setup(refreshControl: UIRefreshControl) {
        collectionView.addSubview(refreshControl)
    }

    func setup(camesCollectionViewDataProvider: GamesCollectionViewDataProvider) {
        self.camesCollectionViewDataProvider = camesCollectionViewDataProvider
    }

    func show(error: Error?) {
        loadingView.stopLoading()
        guard let error = error else { return }
        print(error)
    }

}

extension ListGamesView: ListTopGamesPresenter {

    func list(games: [Game]) {
        camesCollectionViewDataProvider.update(with: games)
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
        let image = UIImage(data: data)
        camesCollectionViewDataProvider.updateGameCover(id: id, image: image)

        if let row = camesCollectionViewDataProvider.row(ofId: id) {
            let intedPathToUpdate = IndexPath(row: row, section: 0)
            DispatchQueue.main.async { [unowned self] in
                self.collectionView.reloadItems(at: [intedPathToUpdate])
            }
        }
    }

}
