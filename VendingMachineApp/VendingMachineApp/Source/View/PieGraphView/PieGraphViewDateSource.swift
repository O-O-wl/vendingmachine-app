//
//  PieGraphDateSource.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/11.
//  Copyright © 2019 부엉이. All rights reserved.
//

import Foundation

protocol PieGraphViewDateSource: AnyObject {
    
    func numOfTotal(in pieGraphView: PieGraphView) -> Int
    func numOfCategories(in pieGraphView: PieGraphView) -> Int
    func pieGraphView(_ pieGraphView: PieGraphView, statisticOfItem index: Int) -> Statistic
}
