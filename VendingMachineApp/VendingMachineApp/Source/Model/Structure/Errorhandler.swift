//
//  Errorhandler.swift
//  VendingMachine
//
//  Created by 이동영 on 24/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct ErrorHandler {
    
    private let error: Error

    init(error: Error) {
        self.error = error
    }

    func handle(logic: (Error) -> Void) {
        logic(error)
    }
}
