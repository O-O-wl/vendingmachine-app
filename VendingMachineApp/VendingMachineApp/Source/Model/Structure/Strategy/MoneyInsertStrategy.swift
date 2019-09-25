//
//  MoneyInsert.swift
//  VendingMachine
//
//  Created by 이동영 on 21/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct MoneyInsertStrategy: StateHandleable {
    private let moneyToAdd: Money
    private let completion: (Money) -> Void

    init(moneyToAdd: Money, completion: @escaping (Money) -> Void) {
        self.moneyToAdd = moneyToAdd
        self.completion = completion
    }

    func handle(_ before: State) -> Result<State, Error> {
        let balence  = before.balance + moneyToAdd

        return .success((balence, before.inventory, before.history))
    }

    func complete() {
        completion(moneyToAdd)
    }

}
