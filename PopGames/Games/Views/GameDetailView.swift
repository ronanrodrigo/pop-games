import UIKit

class GameDetailView: NibLoadableView {

    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var viewersLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!

    func setup(game: Game, image: UIImage?) {
        nameLabel.text = game.name.uppercased()
        viewersLabel.text = "\(game.viewers)"
        popularityLabel.text = "\(game.popularity)"
        coverImageView.image = image
    }

}
