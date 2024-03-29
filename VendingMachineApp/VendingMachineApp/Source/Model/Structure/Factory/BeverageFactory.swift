//
//  StorableFactory.swift
//  VendingMachine
//
//  Created by 이동영 on 29/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct BeverageFactory {
    static let supportedTypes = [Americano.self,
                                 CafeLatte.self,
                                 ChocolateMilk.self,
                                 Cola.self,
                                 EnergyDrink.self,
                                 StrawberryMilk.self]

    static func createAll(quantity: Int) -> [Beverage] {
        return Array.init(0..<quantity)
            .map { _ in
                supportedTypes.map { $0.init() }
            }
            .reduce(into: [Beverage]()) {
                $0.append(contentsOf: $1)
        }
    }

    static func create(index: Int) -> Beverage? {
        guard
            index < supportedTypes.count
            else { return nil }
        return supportedTypes[index].init()
    }
}
