//
//  HistoryCollectionViewManager.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation
import UIKit

class HistoryCollectionViewManager: NSObject, UICollectionViewDataSource {
    unowned var service = VendingMachineService.shared
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return service.numOfSoldItem
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SoldProductCell.reuseId,
                                                      for: indexPath)
        guard
            let productCell = cell as? SoldProductCell
            else { return cell }
        let model = service.cellForSoldItemAt(index: indexPath.row)
        productCell.configure(model: model)
        return productCell
    }
    
}
// MARK: - + UICollectionViewDelegateFlowLayout
extension HistoryCollectionViewManager: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow: CGFloat = 6
        let side = collectionView.bounds.width/numberOfCellsInRow
        return CGSize(width: side,
                      height: side)
    }
}
