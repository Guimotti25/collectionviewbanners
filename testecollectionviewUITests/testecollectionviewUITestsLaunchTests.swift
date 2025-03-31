import XCTest

final class testecollectionviewUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Verifica se os elementos principais estão visíveis na tela inicial
        XCTAssertTrue(app.collectionViews["collectionViewBanner"].waitForExistence(timeout: 5))
        XCTAssertTrue(app.pageIndicators["pageControl"].exists)
        
        // Tira screenshot para documentação
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
