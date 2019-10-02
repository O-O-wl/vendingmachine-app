//
//  Beverage.swift
//  VendingMachine
//
//  Created by 이동영 on 13/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Product: class {
    var productName: String { get }
    var productPrice: Money { get }
    var isHot: Bool { get }
    var isDue: Bool { get }
}

extension Product {
    var productDescription: String {
        return "\(productName) \(productPrice)"
    }
}

class Beverage {
    // MARK: - Properties
    static let standardTemperature = 20

    private let brand: String
    private let capacity: Int
    private let price: Int
    private let name: String
    private let productDate: Date
    private let storeDuration: TimeInterval
    private var expirationDate: Date {
        return productDate + storeDuration
    }

    private let temperature: Int

    // MARK: - Methods
    init(brand: String = "제조사",
         capacity: Int = 0,
         price: Int,
         name: String,
         productDate: Date = Date(),
         storeDuration: Int = 5,
         temperature: Int = standardTemperature) {
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.productDate = productDate
        self.storeDuration = storeDuration.dayDuration
        self.temperature = temperature
    }

    required convenience init () {
        self.init(price: 0,
                  name: "음료")
    }
}
// MARK: - + CustomStringConvertible
extension Beverage: CustomStringConvertible {
    var description: String {
        return "\(brand), \(capacity)ml, \(price)원, \(name), \(productDate.text)"
    }
}
// MARK: - + CustomStringConvertible
extension Beverage: Product {
    
    static func == (lhs: Beverage, rhs: Beverage) -> Bool {
        return lhs.name == rhs.name
    }
    
    var productName: String {
        return self.name
    }

    var productPrice: Money {
        return Money(value: self.price)
    }

    var isHot: Bool {
        return temperature > Beverage.standardTemperature
    }

    var isDue: Bool {
        let nowDate = Date()
        return expirationDate < nowDate
    }
}
extension Beverage: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(productName)
    }
    
}
