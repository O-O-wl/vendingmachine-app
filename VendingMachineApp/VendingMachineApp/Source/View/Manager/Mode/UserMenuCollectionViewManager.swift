//
//  MenuUserCollectionViewManager.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/03.
//  Copyright © 2019 부엉이. All rights reserved.
//
import UIKit
import Foundation

class UserMenuCollectionViewManager: MenuCollectionViewManager {
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        if let cell = cell as? ProductCell {
            cell.delegate = self
            cell.setStyle(style: .customer)
        }
        return cell
    }
    
}
// MARK: + CellButtonDelegate
extension UserMenuCollectionViewManager: CellButtonDelegate {
    
    func cellButton(_ button: UIButton, didSelectItemAt indexPath: IndexPath) {
        let strategy = PurchaseStrategy(productToPurchaseIndex: indexPath.row,
                                        completion: { _, _ in })
        service.setStrategy(strategy)
        do {
            try service.execute()
        } catch let error {
            errorHandler?.handle(error)
        }
    }
}
