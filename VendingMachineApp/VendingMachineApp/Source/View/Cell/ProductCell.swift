//
//  ProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

protocol ProductCellDelegate: class {
    func add(_ indexPath: IndexPath)
    func purchase(_ indexPath: IndexPath)
}

class ProductCell: BaseProductCell {
    
    // MARK: Properties
    static let reuseId = "ProductCell"
    static let nibName = URL(fileURLWithPath: #file).deletingPathExtension().lastPathComponent
    
    weak var delegate: ProductCellDelegate?
    var indexPath: IndexPath?
    
    // MARK: IBOutlet
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    
    // MARK: Method
    
    func configure(product: ProductCellData) {
        productImageView.image = UIImage(named: product.productName)
        productQuantityLabel.text = "\(product.productQuantity)개"
    }
    // MARK: IBActions
    
    @IBAction func addButtonDidTap(_ sender: Any) {
        guard
            let indexPath = indexPath
            else { return }
        delegate?.add(indexPath)
    }
    
    @IBAction func purchaseButtonDidTap(_ sender: Any) {
        guard
            let indexPath = indexPath
            else { return }
        delegate?.purchase(indexPath)
    }
}
