//
//  PieGraphDateSource.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/11.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

protocol PieGraphViewDateSource: AnyObject {
    
    func pieGraphView(_ tableView: PieGraphView, numOfItems index: Int) -> Int
    func pieGraphView(_ tableView: PieGraphView, ratioForTotal index: Int) -> Ratio
}
