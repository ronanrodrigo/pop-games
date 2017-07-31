import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet private weak var gameDetailView: GameDetailView! {
        didSet {
            gameDetailView.setup(game: game, image: cover)
        }
    }

    private var game: Game!
    private var cover: UIImage!

    func setup(game: Game, cover: UIImage?) {
        self.game = game
        self.cover = cover
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = game.name
    }

}
