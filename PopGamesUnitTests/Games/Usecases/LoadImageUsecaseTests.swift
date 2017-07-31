import XCTest
@testable import PopGames

class LoadImageUsecaseTests: XCTestCase {

    private var id = 666
    private var url = "http://www.com.br"
    private var loadImageUsecase: LoadImageUsecase!
    private var imageCacheGateway: ImageCacheGatewayStub!
    private var loadImageGateway: LoadImageGatewayStub!
    private var loadImagePresenter: LoadImagePresenterStub!

    override func setUp() {
        super.setUp()
        imageCacheGateway = ImageCacheGatewayStub()
        loadImageGateway = LoadImageGatewayStub()
        loadImagePresenter = LoadImagePresenterStub()
        loadImageUsecase = LoadImageUsecase(imageCacheGateway: imageCacheGateway,
                                            loadImagePresenter: loadImagePresenter,
                                            loadImageGateway: loadImageGateway)
    }

    func testLoadImageWhenExistChacedImageThenJustPresentImage() {
        imageCacheGateway.setupExistCacheForKey = true
        imageCacheGateway.setupValueForKey = Data()

        loadImageUsecase.load(id: id, url: url)

        XCTAssertTrue(imageCacheGateway.didCallExistCacheForKey)
        XCTAssertTrue(loadImagePresenter.didCallShowStub)
    }

    func testLoadImageWhenExistChacedImageAndTrhowExceptionAtCacheAccessThenJustPresentError() {
        imageCacheGateway.setupExistCacheForKey = true
        imageCacheGateway.setupValueForKeyError = ImageCacheError.notFound

        loadImageUsecase.load(id: id, url: url)

        XCTAssertTrue(loadImagePresenter.didShowErrorStub)
    }

    func testLoadImageWhenDoesNotExistCachedImageThenCacheImage() {
        imageCacheGateway.setupExistCacheForKey = false
        imageCacheGateway.setupValueForKey = Data()
        loadImageGateway.setupLoadResult = Result.success(Data())

        loadImageUsecase.load(id: id, url: url)

        XCTAssertTrue(loadImageGateway.didCallLoadUrl)
        XCTAssertTrue(imageCacheGateway.didCallCacheKeyValue)
    }

    func testLoadImageWhenDoesNotExistCachedImageThenPresentImage() {
        imageCacheGateway.setupExistCacheForKey = false
        imageCacheGateway.setupValueForKey = Data()
        loadImageGateway.setupLoadResult = Result.success(Data())

        loadImageUsecase.load(id: id, url: url)

        XCTAssertTrue(loadImageGateway.didCallLoadUrl)
        XCTAssertTrue(loadImagePresenter.didCallShowStub)
    }

    func testLoadImageWhenDoesNotExistCachedImageAndLoadByUrlFailThenPresentError() {
        imageCacheGateway.setupExistCacheForKey = false
        imageCacheGateway.setupValueForKey = Data()
        loadImageGateway.setupLoadResult = Result.fail(nil)

        loadImageUsecase.load(id: id, url: url)

        XCTAssertTrue(loadImageGateway.didCallLoadUrl)
        XCTAssertTrue(loadImagePresenter.didShowErrorStub)
    }

}
