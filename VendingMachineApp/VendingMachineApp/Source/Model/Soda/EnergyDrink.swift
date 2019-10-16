//
//  RedBull.swift
//  VendingMachine
//
//  Created by 이동영 on 14/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class EnergyDrink: Soda {
    // MARK: - Properties
    static let stanardCaffeineContent: Int = 100
    static let recommendedConsumerPrice = 1500

    private let caffeineContent: Int

    var isHighCaffeine: Bool {
        return EnergyDrink.stanardCaffeineContent < self.caffeineContent
    }

    // MARK: - Methods

    /// initialize instance of EnergyDrink
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "에너지 드링크".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter isSugerFree: a bool indicating whether or not has suger. default is false.
    /// - Parameter caffeineContent: a int value how many contain caffeine
    /// ⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int = recommendedConsumerPrice,
         name: String = "EnergyDrink",
         productDate: Date = Date(),
         temperature: Int = standardTemperature,
         storeDuration: Int = 30,
         isSugerFree: Bool = false,
         caffeineContent: Int = stanardCaffeineContent) {
        self.caffeineContent = caffeineContent > capacity ? capacity : caffeineContent

        super.init(brand: brand,
                   capacity: capacity,
                   price: price,
                   name: name,
                   productDate: productDate,
                   storeDuration: storeDuration,
                   temperature: temperature,
                   isSugerFree: isSugerFree)
    }

    required convenience init () {
        self.init(price: EnergyDrink.recommendedConsumerPrice,
                  name: "EnergyDrink")
    }
    
    required init?(coder: NSCoder) {
        self.caffeineContent = coder.decodeInteger(forKey: Keys.caffeineContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(caffeineContent, forKey: Keys.caffeineContent.rawValue)
        super.encode(with: coder)
    }
    
    enum Keys: String {
        case caffeineContent = "CaffeineContent"
    }
}
