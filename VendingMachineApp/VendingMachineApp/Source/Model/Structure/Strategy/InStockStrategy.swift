//
//  InStockStrategy.swift
//  VendingMachine
//
//  Created by 이동영 on 02/09/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct InStockStrategy: StateHandleStrategy {
    private var stockToAddIndex: Int
    private let completion: (String) -> Void
    private var stockToAdd: Beverage?
    
    init(stockToAddIndex: Int,
         completion: @escaping (String) -> Void = { _ in }) {
        self.stockToAddIndex = stockToAddIndex
        self.completion = completion
    }
    
    mutating func setItemIndex(at index: Int) {
        stockToAddIndex = index
    }
    
    func handle(_ before: State) -> Result<State, Error> {
        let state = before
        guard let stockToAdd = state.inventory.search(at: stockToAddIndex)
            else { return .failure(InStockError.noSale) }
        state.inventory.addStock(stockToAdd)
        
        return .success(state)
    }
    
    func complete() {
        guard let stockToAdd = stockToAdd
            else { return }
        completion(stockToAdd.productName)
    }
    
    // MARK: - InStockError
    enum InStockError: LocalizedError {
        case noSale
        
        var errorDescription: String? {
            switch self {
            case .noSale:
                return "판매하는 상품이 아닙니다.❌"
            }
        }
    }
    
}
