//
//  Errorhandler.swift
//  VendingMachine
//
//  Created by 이동영 on 24/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    
    let logic: (Error) -> Void
    
    func handle(_ error: Error) {
        logic(error)
    }
}
