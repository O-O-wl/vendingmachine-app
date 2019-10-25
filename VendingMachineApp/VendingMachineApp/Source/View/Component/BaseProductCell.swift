//
//  BaseProductCell.swift
//  VendingMachineApp
//
//  Created by 이동영 on 25/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class BaseProductCell: UICollectionViewCell {
    
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
}
