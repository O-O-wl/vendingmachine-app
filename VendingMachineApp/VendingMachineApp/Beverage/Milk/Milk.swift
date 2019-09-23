//
//  Milk.swift
//  VendingMachine
//
//  Created by 이동영 on 13/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Milk: Beverage {
    // MARK: - Properties
    static let stanardFatContent = 100
    static let stanardLactaseContent = 100

    private let fatContent: Int
    private let lactaseContent: Int

    private var isLowFat: Bool {
        return Milk.stanardFatContent >= fatContent
    }
    private var isDisgestible: Bool {
        return Milk.stanardFatContent <= fatContent
    }

    // MARK: - Methods
    init(
        brand: String = "제조사",
        capacity: Int = 0,
        price: Int,
        name: String,
        productDate: Date = Date(),
        storeDuration: Int = 7,
        temperature: Int = standardTemperature,
        fatContent: Int = stanardFatContent,
        lactaseContent: Int = stanardLactaseContent ) {
        self.fatContent = fatContent
        self.lactaseContent = lactaseContent

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
                  name: "우유")
    }
}

protocol Sweetable {
    var isSweet: Bool { get }
}
