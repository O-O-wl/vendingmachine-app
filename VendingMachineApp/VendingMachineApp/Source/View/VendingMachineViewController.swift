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
    }
    
}
// MARK: - + VendingMachineView
extension VendingMachineViewController: VendingMachineView {
    func displayProducts() {
        
    }
    func displayBalance() {
        
    }
}
