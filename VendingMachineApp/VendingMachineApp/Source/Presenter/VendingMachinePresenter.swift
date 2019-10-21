//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by 이동영 on 16/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

typealias State = (balance: Money, inventory: Storable, history: History)

protocol VendingMachinePresenterType: class, MoneyHandleable {
    var numOfRow: Int { get }
    func cellForItemAt(index: Int) -> ProductStatistic
    func setStrategy(_ strategy: StateHandleable?)
    func searchItem(at index: Int) -> Beverage?
    func execute() throws
}

class VendingMachinePresenter: NSObject, NSCoding {
    
    private static var _shared: VendingMachinePresenter?
    
    static var shared: VendingMachinePresenter {
        if let shared = _shared {
            return shared
        } else {
            _shared = UserDefaultsManager.load(type: VendingMachinePresenter.self)
        }
        return _shared ?? .init(balance: Money(value: 0),
                                inventory: Inventory(products: BeverageFactory.createAll(quantity: 0)),
                                history: History())
    }
    
    var isOnSale: Bool {
        return !inventory.filter(by: .all).isEmpty
    }
    private var balance: Money
    private var inventory: Storable
    private var history: History
    private var strategy: StateHandleable?
    
    private init(balance: Money,
                 inventory: Storable,
                 history: History) {
        self.balance = balance
        self.inventory = inventory
        self.history = history
    }
    
    // MARK: NSCoding
    required init?(coder: NSCoder) {
        self.balance = coder.decodeObject(forKey: Keys.balance.rawValue) as! Money
        self.inventory = coder.decodeObject(forKey: Keys.inventory.rawValue) as! Inventory
        self.history = coder.decodeObject(forKey: Keys.history.rawValue) as! History
    }
    
    static func destory() {
        _shared = nil
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(balance, forKey: Keys.balance.rawValue)
        coder.encode(inventory, forKey: Keys.inventory.rawValue)
        coder.encode(history, forKey: Keys.history.rawValue)
    }
    
    func searchItem(at index: Int) -> Beverage? {
        return inventory.search(at: index)
    }
    
    func setStrategy(_ strategy: StateHandleable?) {
        self.strategy = strategy
    }
    
    func execute() throws {
        let state = (balance: balance, inventory: inventory, history: history)
        
        guard
            let result = strategy?.handle(state)
            else { return }
        try resultHandle(result)
    }
    
    func handleStrategy(_ handler: (StateHandleable) -> Void) {
        guard
            let strategy = strategy
            else { return }
        handler(strategy)
    }
    
    func resultHandle(_ result: Result<State, Error>) throws {
        switch result {
        case .success(let newState):
            (self.balance, self.inventory, self.history) = newState
            self.strategy?.complete()
        case .failure(let error):
            throw error
        }
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: MoneyHandleable {
    
    func handleMoney(_ handler: (Money) -> Void) {
        handler(balance)
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachinePresenter: ProductStatisticHandleable {
    
    func handleProductStatistic(_ handler: ([ProductStatistic]) -> Void) {
        handler(inventory.statistic)
    }
}
// MARK: - + VendingMachinePresenterType
extension VendingMachinePresenter: VendingMachinePresenterType {
    
    var numOfRow: Int {
        return inventory.statistic.count
    }
    
    func cellForItemAt(index: Int) -> ProductStatistic {
        return inventory.statistic[index]
    }
    
}
// MARK: - + Saveable
extension VendingMachinePresenter: Saveable {
    
    static var key: String {
        return String(describing: self)
    }
    
}
// MARK: Keys
extension VendingMachinePresenter {
    enum Keys: String {
        case balance = "Balance"
        case inventory = "Inventory"
        case history = "History"
    }
}
