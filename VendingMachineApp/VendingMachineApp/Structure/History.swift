//
//  History.swift
//  VendingMachine
//
//  Created by 이동영 on 25/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct History {
    private var soldProducts = [Product]()

    mutating func record(soldProduct: Product) {
        soldProducts.append(soldProduct)
    }

    mutating func eraseAll(product: Product) {
        soldProducts.removeAll()
    }

}
