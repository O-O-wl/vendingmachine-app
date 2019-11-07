//
//  MoneyInsert.swift
//  VendingMachine
//
//  Created by 이동영 on 21/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MoneyInsertStrategy: MoneyHandStrategy {
    
    private let moneyToAdd: Money
    private let completion: (Money) -> Void

    init(moneyToAdd: Money, completion: @escaping ((Money) -> Void) = { _ in }) {
        self.moneyToAdd = moneyToAdd
        self.completion = completion
    }
    
    func handle(_ before: Money) -> Result<Money, Error> {
        let balence  = before + moneyToAdd

        return .success(balence)
    }

    func complete() {
        completion(moneyToAdd)
    }

}
