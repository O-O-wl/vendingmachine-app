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
    lazy var presenter: VendingMachinePresenterType!
        = VendingMachinePresenter(balance: Money(value: 0),
                                  inventory: Inventory(products: ProductFactory.createAll(quantity: 1)),
                                  history: History())
    
    // MARK: IBOutlet
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var add1000WonButton: UIButton!
    @IBOutlet weak var add5000WonButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: Methods
    // MARK: IBAction
    
    @IBAction func addBalanceButton(_ sender: UIButton) {
        let amount = Int(sender.titleLabel!.text!)
        let strategy = MoneyInsertStrategy(moneyToAdd: Money(value: amount!),
                                           completion: { _ in () } )
        presenter.setStrategy(strategy)
        try? presenter.execute()
        displayBalance()
    }

    // MARK: ViewController Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        displayBalance() 
    }
    
    func setupCollectionView() {
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        
        let productCellNib = UINib(nibName: ProductCell.nibName,
                                   bundle: .main)
        productsCollectionView.register(productCellNib,
                                        forCellWithReuseIdentifier: ProductCell.reuseId)
        productsCollectionView.isScrollEnabled = false
    }
    
}
// MARK: - + VendingMachineView
extension VendingMachineViewController: VendingMachineView {
    func displayProducts() {
        productsCollectionView.reloadData()
    }
    func displayBalance() {
        presenter.handleMoney { self.balanceLabel.text = $0.description }
    }
}

extension VendingMachineViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let selected = ProductFactory.create(index: indexPath.row)
            else { return }
        presenter.setStrategy(InStockStrategy(stockToAdd: selected,
                                              completion: { _ in }))
        try? presenter.execute()
        productsCollectionView.reloadData()
    }
}
// MARK: - + UICollectionViewDataSource
extension VendingMachineViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return presenter.numOfRow
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId,
                                                      for: indexPath)
        guard
            let productCell = cell as? ProductCell
            else { return cell }
        productCell.backgroundColor = .white
        presenter.configure(cell: productCell, index: indexPath.row)
        return productCell
    }
    
}
// MARK: - + UICollectionViewDelegateFlowLayout
extension VendingMachineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow: CGFloat = CGFloat(collectionView.numberOfItems(inSection: indexPath.section)) + 1
        let side = collectionView.bounds.width/numberOfCellsInRow
        
        return CGSize(width: side, height: side)
    }
}

