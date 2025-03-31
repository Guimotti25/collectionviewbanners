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
        // Verifica se o número de células corresponde ao esperado (4)
        let collectionView = app.collectionViews["collectionViewBanner"]
        let cells = collectionView.cells
        XCTAssertEqual(cells.count, 4, "Número incorreto de banners na CollectionView")
    }
    
    func testBannerImagesAreLoaded() throws {
        // Verifica se as imagens estão sendo exibidas
        let firstCell = app.collectionViews["collectionViewBanner"].cells.firstMatch
        XCTAssertTrue(firstCell.images.firstMatch.exists, "A primeira imagem do banner não foi carregada")
    }
    
    func testPageControlSyncWithCollectionView() throws {
        // Verifica se o PageControl está sincronizado com a CollectionView
        let collectionView = app.collectionViews["collectionViewBanner"]
        let pageControl = app.pageIndicators["pageControl"]
        
        // Rola para o próximo item
        collectionView.swipeLeft()
        
        // Verifica se o PageControl atualizou
        XCTAssertEqual(pageControl.value as? String, "page 2 of 4", "PageControl não está sincronizado com a CollectionView")
    }
    
    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
