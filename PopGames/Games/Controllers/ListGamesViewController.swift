import UIKit

protocol DidSelectGame {
    func didSelectGameAt(row: Int)
}

class ListGamesViewController: UIViewController {

    @IBOutlet private var listGamesView: ListGamesView! {
        didSet {
            listGamesView.setup(refreshControl: refreshControl)
            listGamesView.setup(didSelectGame: self)
        }
    }

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshGames), for: .valueChanged)
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        saveTopGames()
    }

    private func saveTopGames() {
        SaveTopGamesUseCaseFactory.make(saveGamesPresenter: listGamesView.saveGamesPresenter).save()
        NotificationCenter.default.addObserver(self, selector: #selector(listTopGames),
                                               name: NSNotification.Name.Game.didSaveGames, object: nil)
    }

    @objc private func listTopGames() {
        ListTopGamesUseCaseFactory.make(presenter: listGamesView.listTopGamesPresenter).list()
    }

    @objc private func refreshGames() {
        saveTopGames()
        listTopGames()
    }

}

extension ListGamesViewController: DidSelectGame {

    func didSelectGameAt(row: Int) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let gameDetailViewController = storyboard.instantiateViewController(
            withIdentifier: "GameDetailViewController") as? GameDetailViewController else { return }
        let gameAndImage = listGamesView.gameAt(row: row)
        gameDetailViewController.setup(game: gameAndImage.game, cover: gameAndImage.cover)
        navigationController?.pushViewController(gameDetailViewController, animated: true)
    }

}
