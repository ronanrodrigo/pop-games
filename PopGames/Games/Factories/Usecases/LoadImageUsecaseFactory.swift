struct LoadImageUsecaseFactory {

    static func make(presenter: LoadImagePresenter) -> LoadImageUsecase {
        return LoadImageUsecase(
            imageCacheGateway: ImageCacheDictionaryGatewayFactory.make(),
            loadImagePresenter: presenter,
            loadImageGateway: LoadImageRestAPIGatewayFactory.make())
    }

}
