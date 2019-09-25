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

    // MARK: IBOutlet
    @IBOutlet weak var addQuantityButton: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!

    // MARK: Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ product: Product) {
        productImageView.image = UIImage(named: "\(type(of: product))")
        productImageView.backgroundColor = .green
    }

    // MARK: IBAction
    @IBAction func addQuantityButtonDidTap(_ sender: UIButton) {

    }
}
