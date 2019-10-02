//
//  Extensions.swift
//  VendingMachine
//
//  Created by 이동영 on 13/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation
import UIKit

func print<T: Beverage>(beverage: T) {
    print("\(type(of: beverage)) - \(beverage.description)")
}
// MARK: - Date Extension
extension Date {
    var text: String {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "yyyyMMdd"
        return dateFormmater.string(from: self)
    }
}
// MARK: - Int Extesion
extension Int {
    var dayDuration: TimeInterval {
        let secOfDay = 86400
        return TimeInterval(self * secOfDay)
    }
}
// MARK: - Array Extension
extension Array where Element == String {
    var countDictionary: [String: Int] {
        var statistic = [String: Int]()
        self.forEach { statistic[$0] = (statistic[$0] ?? 0) + 1 }
        return statistic
    }
}

extension Array where Element == Product {
    private var allProductDictionary: [String: Int] {
        return [ StrawberryMilk().productDescription: 0,
                 ChocolateMilk().productDescription: 0,
                 Cola().productDescription: 0,
                 EnergyDrink().productDescription: 0,
                 Americano().productDescription: 0,
                 CafeLatte().productDescription: 0] }

    var countDictionary: [String: Int] {
        var temp = allProductDictionary
        for product in self {
            temp[product.productDescription] = (temp[product.productDescription] ?? 0) + 1
        }
        return temp
    }
}
// MARK: - Dictionary Extension
extension Dictionary where Key == String, Value == Int {
    var sortedList: [(String, Int)] {
        return self.sorted(by: <)
    }
}

extension CALayer {
    
}
