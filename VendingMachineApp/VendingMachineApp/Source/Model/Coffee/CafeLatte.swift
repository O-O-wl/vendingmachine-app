//
//  CafeLatte.swift
//  VendingMachine
//
//  Created by 이동영 on 13/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class CafeLatte: Coffee {
    // MARK: - Properties
    static let stanardMilkContent = 200
    static let recommendedConsumerPrice = 3000
    
    private let milkContent: Int
    
    var isSoft: Bool {
        return milkContent > CafeLatte.stanardMilkContent
    }
    
    // MARK: - Methods
    
    /// initialize instance of Americano
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "카페라떼".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter coffeeBean: a coffeeBeanType indicating what type of CoffeeBean has.
    /// - Parameter milkContent: a int value how many contain milk
    /// ⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int = recommendedConsumerPrice,
         name: String = "CafeLatte",
         productDate: Date = Date(),
         storeDuration: Int = 7,
         temperature: Int = standardTemperature,
         coffeeBean: CoffeeBean = .arabica,
         milkContent: Int = stanardMilkContent) {
        self.milkContent = milkContent > capacity ? capacity : milkContent
        
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
        self.init(price: CafeLatte.recommendedConsumerPrice,
                  name: "CafeLatte")
    }
    
    // MARK: NSCoding
    required init?(coder: NSCoder) {
        self.milkContent = coder.decodeInteger(forKey: Keys.milkContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(milkContent, forKey: Keys.milkContent.rawValue)
        super.encode(with: coder)
    }
    
    enum Keys: String {
        case milkContent = "MilkContent"
    }
    
}
