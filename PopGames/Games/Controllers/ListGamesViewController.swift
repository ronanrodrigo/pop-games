import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet private var listGamesView: ListGamesView! {
        didSet {
            let loadImageUsecase = LoadImageUsecaseFactory.make(presenter: listGamesView.loadImagePresenter)
            let dataProvider = GamesCollectionViewDataProvider(loadImageUsecase: loadImageUsecase) { [unowned self] in
                self.didSelect(game: $0, cover: $1)
            }
            listGamesView.setup(camesCollectionViewDataProvider: dataProvider)
            listGamesView.setup(refreshControl: refreshControl)
        }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(saveTopGames), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        saveTopGames()
    }

    @objc private func saveTopGames() {
        SaveTopGamesUseCaseFactory.make(saveGamesPresenter: listGamesView.saveGamesPresenter).save()
        NotificationCenter.default.addObserver(self, selector: #selector(listTopGames),
                                               name: NSNotification.Name.Game.didSaveGames, object: nil)
    }

    @objc private func listTopGames() {
        ListTopGamesUseCaseFactory.make(presenter: listGamesView.listTopGamesPresenter).list()
        refreshControl.endRefreshing()
    }

    func didSelect(game: Game, cover: UIImage?) {
        let gameDetailViewController = GameDetailViewControllerFactory.make()
        gameDetailViewController.setup(game: game, cover: cover)
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }

}
