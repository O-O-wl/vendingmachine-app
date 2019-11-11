//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by 이동영 on 16/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//
import CoreGraphics
import Foundation

typealias State = (balance: Money, inventory: Storable, history: History)

protocol VendingMachineServiceType: MoneyHandleable, PieGraphViewDateSource {
    var numOfMenu: Int { get }
    func cellForProductAt(index: Int) -> ProductCellData
    func handleBalance(_ strategy: MoneyHandleStrategy) throws
    func setStateStrategy(_ strategy: StateHandleStrategy?)
    func searchItem(at index: Int) -> Beverage?
    func execute() throws
}

protocol SoldHistoryServiceType: class {
    var numOfSoldItem: Int { get }
    func cellForSoldItemAt(index: Int) -> SoldProductCellData
}

class VendingMachineService: NSObject, NSCoding {
    
    private static var _shared: VendingMachineService?
    
    static var shared: VendingMachineService {
        if let shared = _shared {
            return shared
        } else {
            if let loaded = UserDefaultsManager.load(type: VendingMachineService.self) {
                _shared = loaded
            } else {
                _shared = .init(balance: Money(value: 0),
                                inventory: Inventory(products: BeverageFactory.createAll(quantity: 1)),
                                history: History())
            }
        }
        return _shared!
    }
    
    var isOnSale: Bool {
        return !inventory.filter(by: .all).isEmpty
    }
    private var balance: Money {
        didSet {
            NotificationCenter.default.post(name: AppEvent.balanceDidChanged.name,
                                            object: nil)
        }
    }
    private var inventory: Storable {
        didSet {
            NotificationCenter.default.post(name: AppEvent.productsDidChanged.name,
                                            object: nil)
        }
    }
    var history: History {
        didSet {
            NotificationCenter.default.post(name: AppEvent.historyDidChanged.name,
                                            object: nil)
        }
    }
    private var strategy: StateHandleStrategy?
    
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
    
    func setStateStrategy(_ strategy: StateHandleStrategy?) {
        self.strategy = strategy
    }
    
    func execute() throws {
        let state = (balance: balance, inventory: inventory, history: history)
        
        guard let result = strategy?.handle(state)
            else { return }
        try resultHandle(result)
    }
    
    func handleStrategy(_ handler: (StateHandleStrategy) -> Void) {
        guard let strategy = strategy
            else { return }
        handler(strategy)
    }
    
    func handleBalance(_ strategy: MoneyHandleStrategy) throws {
        let result = strategy.handle(balance)
        switch result {
        case .success(let newBalance):
            balance = newBalance
        case .failure(let error):
            throw error
        }
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
extension VendingMachineService: MoneyHandleable {
    
    func handleMoney(_ handler: (Money) -> Void) {
        handler(balance)
    }
    
}
// MARK: - + MoneyHandleable
extension VendingMachineService: ProductStatisticHandleable {
    
    func handleProductStatistic(_ handler: ([ProductCellData]) -> Void) {
        handler(inventory.statistic)
    }
}
// MARK: - + VendingMachinePresenterType
extension VendingMachineService: VendingMachineServiceType {    
    var numOfMenu: Int {
        return inventory.statistic.count
    }
    
    func cellForProductAt(index: Int) -> ProductCellData {
        return inventory.statistic[index]
    }
    
}
// MARK: - + VendingMachinePresenterType
extension VendingMachineService: SoldHistoryServiceType {
    var numOfSoldItem: Int {
        return history.soldProducts.count
    }
    
    func cellForSoldItemAt(index: Int) -> SoldProductCellData {
        let assetName = history.soldProducts[index].productName
        return SoldProductCellData(soldProductAssetName: assetName)
    }
    
}
// MARK: - + Saveable
extension VendingMachineService: Saveable {
    
    static var key: String {
        return String(describing: self)
    }
    
}
// MARK: Keys
extension VendingMachineService {
    enum Keys: String {
        case balance = "Balance"
        case inventory = "Inventory"
        case history = "History"
    }
}
// MARK: - PieGraphDateSource
extension VendingMachineService: PieGraphViewDateSource {
    
    func pieGraphView(_ tableView: PieGraphView, numOfItems index: Int) -> Int {
        return history
            .soldProducts
            .reduce(into: [String: Int]()) { $0[$1.productName] = ($0[$1.productName] ?? 0) + 1  }
            .count
    }
    
    func pieGraphView(_ tableView: PieGraphView, ratioForTotal index: Int) -> Ratio {
        let total = CGFloat(history.soldProducts.count)
        
        let ratios = history
            .soldProducts
            .reduce(into: [String: Int]()) { $0[$1.productName] = ($0[$1.productName] ?? 0) + 1  }
            .sortedList
            .map { (name: $0, ratio: CGFloat($1)/total) }
        
        return ratios[index]
    }
}
