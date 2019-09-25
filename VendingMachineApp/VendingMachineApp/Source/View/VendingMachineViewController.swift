//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

protocol VendingMachineView {
    func displayProducts()
    func displayBalance()
}

class VendingMachineViewController: UIViewController {
    
    // MARK: Properties
    var vendingMachine = VendingMachine(balance: .init(value: 0),
                                        inventory: Inventory.init(products: ProductFactory.createAll(quantity: 1)),
                                        history: History())
    // MARK: IBOutlet
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var buttonToAdd1000Won: UIButton!
    @IBOutlet weak var buttonToAdd5000Won: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: Methods
    // MARK: IBAction
    // MARK: ViewController Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        productsCollectionView.dataSource = self
    }
    
}
extension VendingMachineViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var menuCount = 0
        vendingMachine.handleProductStatistic({ _ in menuCount+=1 })
        return menuCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}
// MARK: - + VendingMachineView
extension VendingMachineViewController: VendingMachineView {
    func displayProducts() {
        
    }
    func displayBalance() {
        
    }
}
