//
//  Handleable.swift
//  VendingMachine
//
//  Created by 이동영 on 24/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol MoneyHandleable {
    func handleMoney(_ handler: (Money) -> Void)
}

protocol ProductStatisticHandleable {
    func handleProductStatistic(_ handler: ([ProductCellData]) -> Void)
}

protocol HistoryHandleable {
    func handleHistory(_ handler: (History) -> Void)
}

