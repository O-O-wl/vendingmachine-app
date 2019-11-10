//
//  AppEvent.swift
//  VendingMachineApp
//
//  Created by 이동영 on 23/10/2019.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

protocol NotificationConvertible {
    var name: NSNotification.Name { get }
}

enum AppEvent: String, NotificationConvertible {
    case productsDidChanged
    case balanceDidChanged
    case historyDidChanged
    
    var name: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }
}
