import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet private var listGamesView: ListGamesView! {
        didSet {
            listGamesView.setup(refreshControl: refreshControl)
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
