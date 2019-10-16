//
//  Beer.swift
//  VendingMachine
//
//  Created by 이동영 on 14/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class Cola: Soda {
    // MARK: - Properties
    static let stanardCocaberryContent = 10
    static let recommendedConsumerPrice = 1800

    private let cocaberryContent: Int

    var isAddictive: Bool {
        return cocaberryContent > Cola.stanardCocaberryContent
    }

    // MARK: - Methods

    /// initialize instance of Cola
    ///
    /// - Parameter brand: brand name. default is "제조사".
    /// - Parameter capacity: product capacity. default is 0.
    /// - Parameter price: Int to  product price. default is 0.
    /// - Parameter name: a string product name. default is "콜라".
    /// - Parameter productDate: product date. default is current date.
    /// - Parameter isSugerFree: a bool indicating whether or not has suger. default is false.
    /// - Parameter cocaberryContent: a int value how many contain cocaberry
    ///⚠️ if this parameter is greater than `capacity`, this value be allocated `conpacity`
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int = recommendedConsumerPrice,
         name: String = "Cola",
         productDate: Date = Date(),
         storeDuration: Int = 30,
         temperature: Int = standardTemperature,
         isSugerFree: Bool = false,
         cocaberryContent: Int = stanardCocaberryContent) {
        self.cocaberryContent = cocaberryContent > capacity ? capacity : cocaberryContent

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
        self.init(price: Cola.recommendedConsumerPrice,
                  name: "Cola")
    }
    
    required init?(coder: NSCoder) {
        self.cocaberryContent = coder.decodeInteger(forKey: Keys.cocaberryContent.rawValue)
        super.init(coder: coder)
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(cocaberryContent, forKey: Keys.cocaberryContent.rawValue)
        super.encode(with: coder)
    }
    
    enum Keys: String {
        case cocaberryContent  = "CocaberryContent"
    }
    
}
