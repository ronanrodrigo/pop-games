import UIKit

class ListGamesViewController: UIViewController {

    @IBOutlet private var listGamesView: ListGamesView!

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

}
