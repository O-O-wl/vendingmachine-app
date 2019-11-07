//
//  VendingMachineHandleable.swift
//  VendingMachine
//
//  Created by 이동영 on 21/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol MoneyHandleStrategy {
    func handle(_ before: Money) -> Result<Money, Error>
    func complete()
}

protocol StateHandleStrategy {
    mutating func handle(_ before: State) -> Result<State, Error>
    mutating func setItemIndex(at index: Int)
    func complete()
}
