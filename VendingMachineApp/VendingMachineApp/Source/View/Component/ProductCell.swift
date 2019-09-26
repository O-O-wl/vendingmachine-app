//
//  ProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

protocol ProductCellType {
    func displayProductImage(imageName: String)
    func displayProductStock(quantity: Int)
}

class ProductCell: UICollectionViewCell {

    // MARK: Properties
    static let reuseId = "ProductCell"
    static let nibName = URL(fileURLWithPath: #file).deletingPathExtension().lastPathComponent

    // MARK: IBOutlet
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!

    // MARK: Method
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    // MARK: IBAction
    @IBAction func addQuantityButtonDidTap(_ sender: UIButton) {

    }
}
extension ProductCell: ProductCellType {
    func displayProductImage(imageName: String) {
        productImageView.image = UIImage(named: imageName)
    }

    func displayProductStock(quantity: Int) {
        productQuantityLabel.text = quantity.description
    }
}
