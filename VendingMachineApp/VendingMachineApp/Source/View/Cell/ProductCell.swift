//
//  ProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

protocol CellButtonDelegate: class {
    func cellButton(_ button: UIButton, didSelectItemAt indexPath: IndexPath)
}

class ProductCell: BaseProductCell {
    
    // MARK: Properties
    static let reuseId = "ProductCell"
    static let nibName = URL(fileURLWithPath: #file).deletingPathExtension().lastPathComponent
    
    weak var delegate: CellButtonDelegate?
    var indexPath: IndexPath?
    
    // MARK: IBOutlet
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productQuantityLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    // MARK: Method
    
    func configure(product: ProductCellData) {
        
        productImageView.image = UIImage(named: product.productName)
        productQuantityLabel.text = "\(product.productQuantity)개"
    }
    // MARK: IBActions
    
    @IBAction func cellButtonDidTap(_ sender: Any) {
        guard let indexPath = indexPath else { return }
        
        delegate?.cellButton(cellButton, didSelectItemAt: indexPath)
    }
    
    func setStyle(style: CellStyle) {
        cellButton.setTitle(style.buttonTitle, for: .normal)
    }
}

struct CellStyle {
    let buttonTitle: String
}
extension CellStyle {
    static var customer = CellStyle(buttonTitle: "구매하기")
    static var admin = CellStyle(buttonTitle: "재고 추가")
}
