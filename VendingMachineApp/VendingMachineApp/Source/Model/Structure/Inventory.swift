//
//  Inventory.swift
//  VendingMachine
//
//  Created by 이동영 on 17/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol Storable {
    var statistic: [ProductStatistic] { get }
    
    mutating func addStock(_ product: Beverage)
    func search(at index: Int) -> Beverage?
    func filter(by option: Option) -> [Beverage]
    mutating func takeOut(_ product: Beverage) -> Beverage?
    
}

class Inventory: NSObject, NSCoding, Storable {
    
    func encode(with coder: NSCoder) {
        coder.encode(stock, forKey: Keys.stock.rawValue)
    }
    
    required init?(coder: NSCoder) {
        self.stock = coder.decodeObject(forKey: Keys.stock.rawValue) as! [Beverage: [Beverage]]
    }
    
    enum Keys: String {
        case stock = "Stock"
    }
    
    private var stock: [Beverage: [Beverage]] = [:]
    
    var statistic: [ProductStatistic] {
        return stock
            .map {
                ProductStatistic(productName: $0.key.productName,
                                 productPrice: $0.key.productPrice.description,
                                 productQuantity: $0.value.count)
        }
    }
    
    init(products category: [Beverage]) {
        var category = category
        while let product = category.popLast() {
            stock[product] = []
        }
    }
    
    func addStock(_ product: Beverage) {
        stock[product]?.append(product)
    }
    
    func search(at index: Int) -> Beverage? {
        return stock.map { $0 }[index].key
    }
    
    func filter(by option: Option) -> [Beverage] {
        return stock
            .filter { option.condition($0.key) }
            .map { $0.key }
    }
    
    func takeOut(_ product: Beverage) -> Beverage? {
        return stock[product]?.popLast()
    }
}

enum Option {
    case all
    case available(balence: Money)
    case hot
    case due
    
    var condition: (Beverage) -> Bool {
        switch self {
        case .all:
            return { _ in true }
        case .available(let balence):
            return { $0.productPrice < balence }
        case .hot:
            return { $0.isHot }
        case .due:
            return { $0.isDue }
        }
        
    }
}
