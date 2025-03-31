import XCTest

final class testecollectionviewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testCollectionViewExists() throws {
        // Verifica se a collectionView existe e está visível
        let collectionView = app.collectionViews["collectionViewBanner"]
        XCTAssertTrue(collectionView.exists, "A CollectionView de banners não foi encontrada")
        XCTAssertTrue(collectionView.isHittable, "A CollectionView não está visível")
    }
    
    func testNumberOfBanners() throws {
        let collectionView = app.collectionViews["collectionViewBanner"]
        let expectedCount = 4 // Ajuste para o número correto
        XCTAssertEqual(collectionView.cells.count, expectedCount,
            "Esperava \(expectedCount) banners, encontrou \(collectionView.cells.count)")
    }
    
    func testBannerImagesAreLoaded() throws {
        // Verifica se as imagens estão sendo exibidas
        let firstCell = app.collectionViews["collectionViewBanner"].cells.firstMatch
        XCTAssertTrue(firstCell.images.firstMatch.exists, "A primeira imagem do banner não foi carregada")
    }
    
    func testPageControlSyncWithCollectionView() throws {
        let collectionView = app.collectionViews["collectionViewBanner"]
        let pageControl = app.pageIndicators["pageControl"]
        
        // Scroll lento e deliberado
        collectionView.swipeLeft(velocity: .slow)
        sleep(1) // Espera a animação
        
        let currentPage = pageControl.value as? String
        XCTAssertTrue(currentPage?.contains("page 2 of") == true,
            "PageControl não atualizou após scroll. Valor atual: \(currentPage ?? "nil")")
    }
    
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
