//
//  CelulaBannerPrincipal.swift
//  SGA Associado
//
//  Created by Guilherme Motti on 05/02/25.
//  Copyright © 2025 Hinova Mobile. All rights reserved.
//

import Foundation
import UIKit

class CelulaBannerPrincipal: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewCelula: UIView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        //self.selectionStyle = UICollectionViewCell.SelectionStyle.none
     //   self.viewCelula.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(abrirModuloPlano)))
        // No método awakeFromNib() ou onde configurar a célula:
        self.imageView.accessibilityIdentifier = "bannerImage"
        self.viewCelula.layer.masksToBounds = true
        self.viewCelula.layer.cornerRadius = 20
    }
}
