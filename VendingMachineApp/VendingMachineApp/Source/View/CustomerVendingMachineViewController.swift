//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit
// MARK: - ProductListDisplayable
protocol ProductListDisplayable {
    
    func displayProducts()
}
// MARK: - BalanceDisplayable
protocol BalanceDisplayable {
    
    func displayBalance()
}
// MARK: - HistoryDisplayble
protocol HistoryDisplayble {
    
    func displayHistory()
}
// MARK: - VendingMachineViewType
protocol VendingMachineViewType: ProductListDisplayable {
    
    var service: VendingMachineServiceType! { get set }
}

// MARK: - CustomerVendingMachineViewController
class CustomerVendingMachineViewController: UIViewController {
    
    // MARK: Properties
    var service: VendingMachineServiceType!
    
    lazy var errorHandler = ErrorHandler { [weak self] error in
        let errorAlert = UIAlertController(error: error)
        self?.present(errorAlert,
                      animated: true)
    }
    lazy var menuCollectionViewManager = UserMenuCollectionViewManager(service: self.service, handler: errorHandler)
    lazy var historyCollectionViewManager = HistoryCollectionViewManager()
    
    // MARK: IBOutlet
    @IBOutlet weak var balanceDisplayView: UIView! {
        didSet {
            balanceDisplayView.layer.shadowOpacity = 1
            balanceDisplayView.layer.shadowOffset = .init(width: -5, height: -5)
            balanceDisplayView.layer.shadowRadius = 15
        }
    }
    @IBOutlet weak var balanceLabel: UILabel! {
        didSet {
            displayBalance()
        }
    }
    @IBOutlet weak var add1000WonButton: UIButton!
    @IBOutlet weak var add5000WonButton: UIButton!
    @IBOutlet weak var menuCollectionView: UICollectionView! {
        didSet {
            setupMenuCollectionView()
        }
    }
    @IBOutlet weak var historyCollectionView: UICollectionView! {
        didSet {
            setupHistoryCollectionView()
        }
    }
    
    // MARK: Methods
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: IBAction
    @IBAction func addBalanceButton(_ sender: UIButton) {
        let amount = Int(sender.titleLabel!.text!)
        let strategy = MoneyInsertStrategy(moneyToAdd: Money(value: amount!),
                                           completion: { _ in ()})
        service.setStrategy(strategy)
        do {
            try service.execute()
        } catch let error {
            errorHandler.handle(error)
        }
    }
    
    // MARK: ViewController Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuCollectionViewManager.errorHandler = errorHandler
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayBalance),
                                               name: AppEvent.balanceDidChanged.name,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayProducts),
                                               name: AppEvent.productsDidChanged.name,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayHistory),
                                               name: AppEvent.historyDidChanged.name,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setupMenuCollectionView() {
        let productCellNib = UINib(nibName: ProductCell.nibName,
                                   bundle: .main)
        
        menuCollectionView.dataSource = menuCollectionViewManager
        menuCollectionView.delegate = menuCollectionViewManager
        menuCollectionView.register(productCellNib,
                                    forCellWithReuseIdentifier: ProductCell.reuseId)
        menuCollectionView.isScrollEnabled = false
    }
    
    private func setupHistoryCollectionView() {
        historyCollectionView.dataSource = historyCollectionViewManager
        historyCollectionView.delegate = historyCollectionViewManager
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = -20
        historyCollectionView.collectionViewLayout = layout
        
        let soldProductCellNib = UINib(nibName: SoldProductCell.nibName,
                                       bundle: .main)
        historyCollectionView.register(soldProductCellNib,
                                       forCellWithReuseIdentifier: SoldProductCell.reuseId)
        historyCollectionView.isScrollEnabled = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var vendingMachineVC = segue.destination as? VendingMachineViewType {
            vendingMachineVC.service = self.service
        }
    }
    
}
// MARK: - + VendingMachineViewType
extension CustomerVendingMachineViewController: VendingMachineViewType {
    
    @objc func displayProducts() {
        menuCollectionView.reloadData()
    }
}
// MARK: - + BalanceDisplayable
extension CustomerVendingMachineViewController: BalanceDisplayable {
    
    @objc func displayBalance() {
        service.handleMoney { self.balanceLabel.text = $0.description }
    }
    
}
// MARK: - + HistoryDisplayble
extension CustomerVendingMachineViewController: HistoryDisplayble {
    
    @objc func displayHistory() {
        historyCollectionView.reloadData()
    }
}
