import UIKit

struct GameDetailViewControllerFactory {

    static func make() -> GameDetailViewController {
        let viewController = UIStoryboard.main.instantiateViewController(
            withIdentifier: String.Identifier.gameDetailViewController) as? GameDetailViewController
        return viewController ?? GameDetailViewController()
    }

}
