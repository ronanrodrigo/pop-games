import Foundation

struct LoadImageUsecase {

    private let imageCacheGateway: ImageCacheGateway
    private let loadImageGateway: LoadImageGateway
    private let loadImagePresenter: LoadImagePresenter

    init(imageCacheGateway: ImageCacheGateway, loadImagePresenter: LoadImagePresenter,
         loadImageGateway: LoadImageGateway) {
        self.imageCacheGateway = imageCacheGateway
        self.loadImagePresenter = loadImagePresenter
        self.loadImageGateway = loadImageGateway
    }

    func load(id: Int, url: String) {
        if imageCacheGateway.existCache(forKey: id) {
            let data = imageCacheGateway.value(forKey: id)
            loadImagePresenter.show(data: data, forId: id)
        } else {
            loadImageGateway.load(url: url).onResult({ result in
                switch result {
                case .success(let data):
                    self.imageCacheGateway.cache(key: id, value: data)
                    self.loadImagePresenter.show(data: data, forId: id)
                case .fail(let error):
                    self.loadImagePresenter.show(error: error)
                }
            })
        }
    }

}
