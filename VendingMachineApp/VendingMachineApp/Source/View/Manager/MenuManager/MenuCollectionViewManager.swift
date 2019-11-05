//
//  MenuCollectionViewManager.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation
import UIKit

class MenuCollectionViewManager: NSObject, UICollectionViewDataSource {
   
    // MARK: - Properties
    var style: CellStyle { return .default }
    // MARK: Dependencies
    var service: VendingMachineServiceType
    var errorHandler: ErrorHandler
    
    // MARK: - Methods
    init(service: VendingMachineServiceType, handler: ErrorHandler) {
        self.service = service
        self.errorHandler = handler
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return service.numOfMenu
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId,
                                                      for: indexPath)
        guard let productCell = cell as? ProductCell else { return cell }
        
        let model = service.cellForProductAt(index: indexPath.item)
        
        productCell.indexPath = indexPath
        productCell.configure(product: model)
        productCell.setStyle(style: style)
        if let delegate = self as? CellButtonDelegate {
            productCell.delegate = delegate
        }
        
        return productCell
    }
}
// MARK: - + UICollectionViewDelegateFlowLayout
extension MenuCollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow = CGFloat(collectionView.numberOfItems(inSection: indexPath.section)) + 1
        let side = collectionView.bounds.width/numberOfCellsInRow
        return CGSize(width: side, height: side)
    }
}
