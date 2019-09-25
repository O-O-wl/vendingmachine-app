//
//  VendingMachineHandleable.swift
//  VendingMachine
//
//  Created by 이동영 on 21/08/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

protocol StateHandleable {
    mutating func handle(_ before: State) -> Result<State, Error>
    func complete()
}
