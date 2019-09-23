//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/09/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let cola = Cola()
        let americano = Americano()
        let cafeLatte = CafeLatte()
        let inventory = Inventory.init(products: [cola, americano, cafeLatte])

        let output = inventory.statistic
            .filter { $0.productQuantity > 0 }
            .reduce("") {
                "\($0) \($1.productDescription) (\($1.productQuantity)개)"
        }

        print(output)
    }

}
