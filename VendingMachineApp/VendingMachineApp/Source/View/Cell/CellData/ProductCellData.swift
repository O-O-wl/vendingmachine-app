//
//  Statistic.swift
//  VendingMachine
//
//  Created by 이동영 on 30/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol ProductDisplayable {
    
    var productName: String { get }
    var productPrice: String { get }
    var productQuantity: Int { get }
}

struct ProductCellData: ProductDisplayable {
    
    var productName: String
    var productPrice: String
    var productQuantity: Int
}

