import Foundation

protocol SaveGamesPresenter {
    func saved()
    func show(error: Error?)
}
