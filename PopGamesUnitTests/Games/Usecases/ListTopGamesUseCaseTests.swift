import XCTest
@testable import PopGames

class ListTopGamesUseCaseTests: XCTestCase {

    private var usecase: ListTopGamesUseCase!
    private var gateway: AllGamesGatewayStub!
    private var presenter: ListTopGamesPresenterStub!

    override func setUp() {
        super.setUp()
        gateway = AllGamesGatewayStub()
        presenter = ListTopGamesPresenterStub()
        usecase = ListTopGamesUseCase(listTopGamesPresenter: presenter, allGamesGateway: gateway)
    }

    func testListTopGamesWhenCompleteRequestWithSuccessThenListGames() {
        gateway.allGamesOnCompleteStub = Result.success([])

        usecase.list()

        XCTAssertTrue(gateway.allGamesStub)
        XCTAssertTrue(presenter.listGamesStub)
    }

    func testListTopGamesWhenCompleteRequestWithFailThenPresentError() {
        gateway.allGamesOnCompleteStub = Result.fail(PopGamesError.invalidRequest)

        usecase.list()

        XCTAssertTrue(gateway.allGamesStub)
        XCTAssertTrue(presenter.showErrorStub)
    }

}
