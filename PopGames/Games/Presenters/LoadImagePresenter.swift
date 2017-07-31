import Foundation

protocol LoadImagePresenter {
    func show(data: Data, forId id: Int)
    func show(error: Error?)
}
