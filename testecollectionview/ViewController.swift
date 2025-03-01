import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionViewBanner: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var listaImagem: [UIImage?] = [
        UIImage(named: "imagem_01"),
        UIImage(named: "imagem_02"),
        UIImage(named: "imagem_03"),
        UIImage(named: "imagem_04")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let celulaBanner = UINib(nibName: "CelulaBannerPrincipal", bundle: nil)
        collectionViewBanner.register(celulaBanner, forCellWithReuseIdentifier: "CelulaBannerPrincipal")

        collectionViewBanner.delegate = self
        collectionViewBanner.dataSource = self

        self.pageControl.numberOfPages = listaImagem.count
        self.pageControl.currentPage = 0
        
        configurarLayoutCollectionView()
    }

    func configurarLayoutCollectionView() 
    {
        let layout = UICollectionViewFlowLayout()
        let larguraDoCard = tamanhoLarguraTelaDispositivo * 0.8884
        let alturaDoCard = tamanhoAlturaTelaDispositivo * 0.23

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: larguraDoCard, height: alturaDoCard)
        layout.minimumLineSpacing = 10 // Espaço entre os cards

        collectionViewBanner.collectionViewLayout = layout
        collectionViewBanner.isPagingEnabled = false // Desativar `pagingEnabled` para controlar a rolagem manualmente
        collectionViewBanner.decelerationRate = .fast // Faz a rolagem ser mais fluida
        
        let inset = (tamanhoLarguraTelaDispositivo - larguraDoCard) / 2
        collectionViewBanner.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    public var tamanhoAlturaTelaDispositivo: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    public var tamanhoLarguraTelaDispositivo: CGFloat {
        return UIScreen.main.bounds.width
    }
}

// MARK: - UICollectionView Delegate & DataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listaImagem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: "CelulaBannerPrincipal", for: indexPath) as! CelulaBannerPrincipal
        celula.imageView.image = listaImagem[indexPath.row]
        celula.imageView.clipsToBounds = true
        return celula
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let larguraDoCard = tamanhoLarguraTelaDispositivo * 0.8884
        let espacoEntreCards: CGFloat = 10
        let larguraTotalDoItem = larguraDoCard + espacoEntreCards
        
        // Calcula o índice da página baseado na posição final do scroll
        let pageIndex = round((targetContentOffset.pointee.x + scrollView.contentInset.left) / larguraTotalDoItem)
        targetContentOffset.pointee = CGPoint(x: pageIndex * larguraTotalDoItem - scrollView.contentInset.left, y: 0)

        pageControl.currentPage = Int(pageIndex)
    }
}
