//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

protocol VendingMachineViewType {
    var presenter: VendingMachinePresenterType! { get set }
    
    func displayProducts()
    func displayBalance()
}

class VendingMachineViewController: UIViewController {
    
    // MARK: Properties
    weak var presenter: VendingMachinePresenterType!
    
    // MARK: IBOutlet
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var add1000WonButton: UIButton!
    @IBOutlet weak var add5000WonButton: UIButton!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: Methods
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: IBAction
    @IBAction func addBalanceButton(_ sender: UIButton) {
        let amount = Int(sender.titleLabel!.text!)
        let strategy = MoneyInsertStrategy(moneyToAdd: Money(value: amount!),
                                           completion: { _ in ()})
        presenter.setStrategy(strategy)
        try? presenter.execute()
        displayBalance()
    }
    
    // MARK: ViewController Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
         
    }
    
    func setupCollectionView() {
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
        let productCellNib = UINib(nibName: ProductCell.nibName,
                                   bundle: .main)
        productsCollectionView.register(productCellNib,
                                        forCellWithReuseIdentifier: ProductCell.reuseId)
        productsCollectionView.isScrollEnabled = false
        
        displayBalance()
    }
    
}
// MARK: - + VendingMachineView
extension VendingMachineViewController: VendingMachineViewType {
    
    func displayProducts() {
        productsCollectionView.reloadData()
    }
    
    func displayBalance() {
        presenter.handleMoney { self.balanceLabel.text = $0.description }
    }
}
// MARK: - + UICollectionView Delegate
extension VendingMachineViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard
            let selected = presenter.searchItem(at: indexPath.item)
            else { return }
        presenter.setStrategy(InStockStrategy(stockToAdd: selected,
                                              completion: { _ in }))
        try? presenter.execute()
        displayProducts()
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
        let model = presenter.cellForItemAt(index: indexPath.item)
        productCell.configure(product: model)
        return productCell
    }
    
}
// MARK: - + UICollectionViewDelegateFlowLayout
extension VendingMachineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let itemSide = collectionView.bounds.width/7
        let insetY = (productsCollectionView.bounds.height - itemSide)/2
        return UIEdgeInsets(top: insetY,
                            left: 15,
                            bottom: 0,
                            right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow: CGFloat = CGFloat(collectionView.numberOfItems(inSection: indexPath.section)) + 1
        let side = collectionView.bounds.width/numberOfCellsInRow
        return CGSize(width: side,
                      height: side)
    }
}

