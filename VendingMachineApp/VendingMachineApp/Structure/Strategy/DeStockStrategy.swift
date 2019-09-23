//
//  DeStockStrategy.swift
//  VendingMachine
//
//  Created by 이동영 on 02/09/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct DeStockStrategy: StateHandleable {
    private let indexOfStockToRemove: Int
    private let completion: (String) -> Void
    private var removedStock: Product?

    init(indexOfStockToRemove: Int,
         completion: @escaping (String) -> Void) {
        self.indexOfStockToRemove = indexOfStockToRemove
        self.completion = completion
    }

    mutating func handle(_ before: State) -> Result<State, Error> {
        var state = before
        guard
            let stockToRemove = state.inventory.search(at: indexOfStockToRemove)
            else { return .failure(RemoveError.noStock)}
        removedStock = state.inventory.takeOut(stockToRemove)
        return .success(state)
    }

    func complete() {
        guard
            let removedStock = removedStock
            else { return }
        completion(removedStock.productName)
    }

    enum RemoveError: LocalizedError {
        case noStock

        var errorDescription: String? {
            switch self {
            case .noStock:
                return "유효하지 않은 재고"
            }
        }
    }
}
