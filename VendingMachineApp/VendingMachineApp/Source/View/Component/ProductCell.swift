//
//  ProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseId = "ProductCell"
    static let nibName = URL(fileURLWithPath: #file).deletingPathExtension().lastPathComponent
    
    // MARK: IBOutlet
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    // MARK: Method
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = self.contentView.frame.width/3
        self.contentView.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 2,
                                         height: 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
    
    func configure(product: ProductStatistic) {
        self.productImageView.image = UIImage(named: product.productName)
        self.productQuantityLabel.text = "\(product.productQuantity)개"
    }
}
