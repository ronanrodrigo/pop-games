import XCTest
@testable import PopGames

class SaveTopGamesUseCaseTests: XCTestCase {

    private var usecase: SaveTopGamesUseCase!
    private var allGamesGateway: AllGamesGatewayStub!
    private var saveGamesGateway: SaveGamesGatewayStub!
    private var saveGamesPresenter: SaveGamesPresenterStub!
    private var cleanGameOnCompleteStub: CleanGamesGatewayStub!

    override func setUp() {
        super.setUp()
        saveGamesGateway = SaveGamesGatewayStub()
        allGamesGateway = AllGamesGatewayStub()
        saveGamesPresenter = SaveGamesPresenterStub()
        cleanGameOnCompleteStub = CleanGamesGatewayStub()
        usecase = SaveTopGamesUseCase(saveGamesGateway: saveGamesGateway,
                                      allGamesGateway: allGamesGateway,
                                      saveGamesPresenter: saveGamesPresenter,
                                      cleanGamesGateway: cleanGameOnCompleteStub)
    }

    func testSaveTopGamesWhenExistGamesThenPresentSaved() {
        allGamesGateway.allGamesOnCompleteStub = Result.success([])
        saveGamesGateway.saveGameOnCompleteStub = Result<Void>.success(())
        cleanGameOnCompleteStub.cleanGameOnCompleteStub = Result<Void>.success(())

        usecase.save()

        XCTAssertTrue(allGamesGateway.allGamesStub)
        XCTAssertTrue(saveGamesGateway.saveStub)
        XCTAssertTrue(saveGamesPresenter.savedStub)
        XCTAssertTrue(cleanGameOnCompleteStub.cleanStub)
    }

    func testSaveTopGamesWhenAnErrorOccursThenPresentError() {
        allGamesGateway.allGamesOnCompleteStub = Result.fail(PopGamesError.invalidRequest)
        cleanGameOnCompleteStub.cleanGameOnCompleteStub = Result<Void>.success(())

        usecase.save()

        XCTAssertTrue(allGamesGateway.allGamesStub)
        XCTAssertFalse(saveGamesGateway.saveStub)
        XCTAssertTrue(saveGamesPresenter.errorStub)
    }

    func testSaveTopGamesWhenAnErrorOccursThenDoesntCleanGames() {
        allGamesGateway.allGamesOnCompleteStub = Result.fail(PopGamesError.invalidRequest)
        saveGamesGateway.saveGameOnCompleteStub = Result<Void>.success(())
        cleanGameOnCompleteStub.cleanGameOnCompleteStub = Result<Void>.success(())

        usecase.save()

        XCTAssertTrue(allGamesGateway.allGamesStub)
        XCTAssertFalse(saveGamesGateway.saveStub)
        XCTAssertTrue(saveGamesPresenter.errorStub)
        XCTAssertFalse(cleanGameOnCompleteStub.cleanStub)
    }
}
