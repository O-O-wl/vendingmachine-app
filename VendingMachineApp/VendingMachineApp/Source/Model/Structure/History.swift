//
//  History.swift
//  VendingMachine
//
//  Created by 이동영 on 25/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class History: NSObject, NSCoding {
    
    var soldProducts = [Beverage]() {
        didSet {
            NotificationCenter.default.post(name: AppEvent.historyDidChanged.name, object: nil)
        }
    }
    
    // MARK: NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(soldProducts, forKey: Keys.soldProducts.rawValue)
    }
    
    init(_ soldProducts: [Beverage] = []) {
        self.soldProducts = soldProducts
    }
    
    required init?(coder: NSCoder) {
        self.soldProducts = coder.decodeObject(forKey: Keys.soldProducts.rawValue) as! [Beverage]
    }
    
    // MARK: Methods
    func record(soldProduct: Beverage) {
        soldProducts.append(soldProduct)
    }
    
    func eraseAll(product: Beverage) {
        soldProducts.removeAll()
    }
    
    enum Keys: String {
        case soldProducts = "SoldProducts"
    }
    
}
