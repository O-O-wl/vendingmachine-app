//
//  SweetMilk.swift
//  VendingMachine
//
//  Created by 이동영 on 14/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class StrawberryMilk: Milk, Sweetable {
    // MARK: - Properties
    static let stanardStrawberryContent = 30
    static let recommendedConsumerPrice = 1300

    private let strawberryContent: Int
    var isSweet: Bool {
        return strawberryContent > StrawberryMilk.stanardStrawberryContent
    }

    // MARK: - Methods

    /// initialize instance of StrawberryMilk
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "딸기우유".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter hasLowFat: a bool indicating whether or not has low fat.  default is false.
    /// - Parameter hasLactase: a bool indicating whether or not has lactase. default is false.
    /// - Parameter strawberryContent: a int value how many contain strawberry
    /// ⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int,
         name: String = "StrawberryMilk",
         productDate: Date = Date(),
         storeDuration: Int = 7,
         temperature: Int = standardTemperature,
         fatContent: Int = stanardFatContent,
         lactaseContent: Int = stanardLactaseContent,
         strawberryContent: Int = stanardStrawberryContent) {
        self.strawberryContent = strawberryContent > capacity ? capacity : strawberryContent

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
        self.init(price: StrawberryMilk.recommendedConsumerPrice,
                  name: "StrawberryMilk")
    }
    
    // MARK: NSCoding
    required init?(coder: NSCoder) {
        self.strawberryContent = coder.decodeInteger(forKey: Keys.strawberryContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(strawberryContent, forKey: Keys.strawberryContent.rawValue)
        super.encode(with: coder)
    }
    
    enum Keys: String {
        case strawberryContent = "StrawberryContent"
    }

}
