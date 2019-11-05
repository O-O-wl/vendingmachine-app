//
//  AdminCollectionViewManager.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/03.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation
import UIKit

class AdminMenuCollectionViewManager: MenuCollectionViewManager {
    override var style: CellStyle { return .admin }
}
// MARK: + CellButtonDelegate
extension AdminMenuCollectionViewManager: CellButtonDelegate {
    
    func cellButton(_ button: UIButton, didSelectItemAt indexPath: IndexPath) {
        guard let beverage = service.searchItem(at: indexPath.row) else { return }
        
        let strategy = InStockStrategy(stockToAdd: beverage,
                                       completion: { _ in })
        service.setStrategy(strategy)
        do {
            try service.execute()
        } catch let error {
            errorHandler.handle(error)
        }
    }
}
