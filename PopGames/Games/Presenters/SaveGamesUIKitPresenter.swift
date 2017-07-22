import UIKit

struct SaveGamesUIKitPresenter: SaveGamesPresenter {

    private let loadingView: LoadingView

    init(loadingView: LoadingView) {
        self.loadingView = loadingView
    }

    func saved() {
        DispatchQueue.main.async { self.loadingView.stopLoading() }
    }

    func error(error: Error?) {
        DispatchQueue.main.async { self.loadingView.stopLoading() }
    }

}
