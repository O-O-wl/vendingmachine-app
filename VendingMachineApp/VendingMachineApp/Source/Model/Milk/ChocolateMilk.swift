//
//  SweetMilk.swift
//  VendingMachine
//
//  Created by 이동영 on 14/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class ChocolateMilk: Milk, Sweetable {
    // MARK: - Properties
    static let stanardChocolateContent = 30
    static let recommendedConsumerPrice = 1300

    private let chocolateContent: Int
    var isSweet: Bool {
        return chocolateContent > ChocolateMilk.stanardChocolateContent
    }

    // MARK: - Methods
    /// initialize instance of ChocolateMilk
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "초코우유".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter hasLowFat: a bool indicating whether or not has low fat.  default is false.
    /// - Parameter hasLactase: a bool indicating whether or not has lactase. default is false.
    /// - Parameter chocolateContent: a int value how many contain chocolate
    ///  ⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int = recommendedConsumerPrice,
         name: String = "초코우유",
         productDate: Date = Date(),
         storeDuration: Int = 7,
         temperature: Int = standardTemperature,
         fatContent: Int = stanardFatContent,
         lactaseContent: Int = stanardLactaseContent,
         chocolateContent: Int = stanardChocolateContent) {
        self.chocolateContent = chocolateContent > capacity ? capacity : chocolateContent
        super.init(brand: brand,
                   capacity: capacity,
                   price: price,
                   name: name,
                   productDate: productDate,
                   storeDuration: storeDuration,
                   temperature: temperature,
                   fatContent: fatContent,
                   lactaseContent: lactaseContent)
    }

    required convenience init () {
        self.init(price: ChocolateMilk.recommendedConsumerPrice,
                  name: "초코우유")
    }
}
