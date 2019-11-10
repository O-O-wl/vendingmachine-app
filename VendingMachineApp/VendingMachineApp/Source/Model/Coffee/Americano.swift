//
//  ㅁmericano.swift
//  VendingMachine
//
//  Created by 이동영 on 14/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Americano: Coffee {
    
    // MARK: - Properties
    static let stanardWaterContent = 300
    static let recommendedConsumerPrice = 2500

    private var waterContent: Int

    var isWatery: Bool {
        return waterContent > Americano.stanardWaterContent
    }

    // MARK: - Methods

    /// initialize instance of Americano
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "아메리카노".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter coffeeBean: a coffeeBeanType indicating what type of CoffeeBean has.
    /// - Parameter waterContent: a int value how many contain water
    /// ⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 500,
         price: Int = recommendedConsumerPrice,
         name: String = "Americano",
         productDate: Date = Date(),
         storeDuration: Int = 15,
         temperature: Int = standardTemperature,
         coffeeBean: CoffeeBean = .arabica,
         waterContent: Int = stanardWaterContent) {
        self.waterContent = waterContent > capacity ? capacity : waterContent

        super.init(brand: brand,
                   capacity: capacity,
                   price: price,
                   name: name,
                   productDate: productDate,
                   storeDuration: storeDuration,
                   temperature: temperature,
                   coffeeBean: coffeeBean)
    }

    required convenience init () {
        self.init(price: Americano.recommendedConsumerPrice,
                  name: "Americano")
    }
    
    // MARK: NSCoding
    required init?(coder: NSCoder) {
        self.waterContent = coder.decodeInteger(forKey: Keys.waterContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(waterContent, forKey: Keys.waterContent.rawValue)
        super.encode(with: coder)
    }
    
    enum Keys: String {
        case waterContent = "WaterContent"
    }
}
