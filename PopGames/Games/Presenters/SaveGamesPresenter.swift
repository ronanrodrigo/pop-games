import Foundation

protocol SaveGamesPresenter {
    func saved()
    func error(error: Error)
}
