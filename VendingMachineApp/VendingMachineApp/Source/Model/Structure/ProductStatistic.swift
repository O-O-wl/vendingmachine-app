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
}

struct ProductStatistic {
    let index: Int
    let productDescription: String
    let productQuantity: Int
}
extension ProductStatistic: ProductDisplayable {
    
    var productName: String {
        return String(productDescription.split(separator: " ")[0])
    }

    var productPrice: String {
       return String(productDescription.split(separator: " ")[1])
    }

}
