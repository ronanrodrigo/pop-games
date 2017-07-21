import XCTest
@testable import PopGames

class SaveTopGamesUseCaseTests: XCTestCase {

    private var usecase: SaveTopGamesUseCase!
    private var allGamesGateway: AllGamesGatewayStub!
    private var saveGamesGateway: SaveGamesGatewayStub!
    private var saveGamesPresenter: SaveGamesPresenterStub!

    override func setUp() {
        super.setUp()
        saveGamesGateway = SaveGamesGatewayStub()
        allGamesGateway = AllGamesGatewayStub()
        saveGamesPresenter = SaveGamesPresenterStub()
        usecase = SaveTopGamesUseCase(saveGamesGateway: saveGamesGateway, allGamesGateway: allGamesGateway,
                                      saveGamesPresenter: saveGamesPresenter)
    }

    func testSaveTopGamesWhenExistGamesThenPresentSaved() {
        allGamesGateway.allGamesOnCompleteStub = Result.success([])
        saveGamesGateway.saveGameOnCompleteStub = Result<Void>.success(())

        usecase.save()

        XCTAssertTrue(allGamesGateway.allGamesStub)
        XCTAssertTrue(saveGamesGateway.saveStub)
        XCTAssertTrue(saveGamesPresenter.savedStub)
    }

    func testSaveTopGamesWhenAnErrorOccursThenPresentError() {
        allGamesGateway.allGamesOnCompleteStub = Result.fail(PopGamesError.invalidRequest)

        usecase.save()

        XCTAssertTrue(allGamesGateway.allGamesStub)
        XCTAssertFalse(saveGamesGateway.saveStub)
        XCTAssertTrue(saveGamesPresenter.errorStub)
    }
}
