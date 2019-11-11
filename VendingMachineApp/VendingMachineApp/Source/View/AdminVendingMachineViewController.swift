//
//  AdminVendingMachineViewController.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/03.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class AdminVendingMachineViewController: UIViewController, VendingMachineViewType {
    
    // MARK: - Properties
    lazy var errorHandler = ErrorHandler { [weak self] error in
        let errorAlert = UIAlertController(error: error)
        self?.present(errorAlert,
                      animated: true)
    }
    lazy var productCollectionViewManager = MenuCollectionViewManager(service: self.service,
                                                                      strategy: InStockStrategy(stockToAddIndex: 0),
                                                                      style: .admin,
                                                                      handler: errorHandler)
    
    // MARK: - Dependencies
    var service: VendingMachineServiceType!
    
    // MARK: IBOIutlet
    @IBOutlet weak var productCollectionView: UICollectionView! {
        didSet {
            setUpCollectionView()
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.layer.cornerRadius = closeButton.bounds.width/2
        }
    }
    
    @IBOutlet weak var pieGraphView: PieGraphView! {
        didSet {
            pieGraphView.dataSource = service
            displayHistory()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayProducts),
                                               name: AppEvent.productsDidChanged.name,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(displayHistory),
                                               name: AppEvent.historyDidChanged.name,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        displayHistory()
    }
    
    private func setUpCollectionView() {
        productCollectionView.dataSource = productCollectionViewManager
        productCollectionView.delegate = productCollectionViewManager
        productCollectionView.register(ProductCell.nib,
                                       forCellWithReuseIdentifier: ProductCell.reuseId)
        productCollectionView.isScrollEnabled = false
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - ProductListDisplayable
extension AdminVendingMachineViewController {
    
    @objc func displayProducts() {
        productCollectionView.reloadData()
    }
    @objc func displayHistory() {
        pieGraphView.history = VendingMachineService.shared.history.soldProducts
    }
}
