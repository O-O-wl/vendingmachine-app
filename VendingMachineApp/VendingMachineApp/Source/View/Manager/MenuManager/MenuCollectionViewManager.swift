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
    // MARK: Dependencies
    private var service: VendingMachineServiceType
    private var strategy: StateHandleStrategy
    private let style: CellStyle
    private let errorHandler: ErrorHandler
    
    // MARK: - Methods
    init(service: VendingMachineServiceType,
         strategy: StateHandleStrategy,
         style: CellStyle,
         handler: ErrorHandler) {
        self.service = service
        self.strategy = strategy
        self.style = style
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
        productCell.delegate = self
        
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
// MARK: - + UICollectionViewDelegateFlowLayout
extension MenuCollectionViewManager: CellButtonDelegate {

    func cellButton(_ button: UIButton, didSelectItemAt indexPath: IndexPath) {
        self.strategy.setItemIndex(at: indexPath.row)
        service.setStateStrategy(self.strategy)
        do {
            try service.execute()
        } catch let error {
            errorHandler.handle(error)
        }
    }
}
