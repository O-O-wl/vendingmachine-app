//
//  SoldProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class SoldProductCell: BaseProductCell {
    
    // MARK: - Properties
    static let reuseId = "SoldProductCell"
    static let nib = UINib(nibName: "SoldProductCell", bundle: nil)
    
    // MARK: - IBOutlet
    @IBOutlet weak var productImageView: UIImageView!
    
    // MARK: - Methods
    func configure(model: SoldProductCellData) {
        productImageView.image = UIImage(named: model.soldProductAssetName)
    }
}
