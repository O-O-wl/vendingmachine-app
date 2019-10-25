//
//  SoldProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class SoldProductCell: BaseProductCell {
    
    static let reuseId = "SoldProductCell"
    static let nibName = URL(fileURLWithPath: #file).deletingPathExtension().lastPathComponent
    @IBOutlet weak var productImageView: UIImageView!
    
    func configure(model: SoldProductCellData) {
        productImageView.image = UIImage(named: model.soldProductAssetName)
    }
}
