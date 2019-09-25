//
//  Soda.swift
//  VendingMachine
//
//  Created by 이동영 on 13/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Soda: Beverage {
    // MARK: - Properties
    private let isSugerFree: Bool

    // MARK: - Methods
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int = 0,
         name: String = "탄산음료",
         productDate: Date = Date(),
         storeDuration: Int = 30,
         temperature: Int = standardTemperature,
         isSugerFree: Bool = false) {
        self.isSugerFree = isSugerFree

        super.init(brand: brand,
                   capacity: capacity,
                   price: price,
                   name: name,
                   productDate: productDate,
                   storeDuration: storeDuration,
                   temperature: temperature)
    }

    required convenience init () {
        self.init(price: 0,
                  name: "탄산음료")
    }
}
