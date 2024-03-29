//
//  PieGraphView.swift
//  VendingMachineApp
//
//  Created by 이동영 on 2019/11/08.
//  Copyright © 2019 부엉이. All rights reserved.
//

import UIKit

typealias Statistic = (name: String, quantity: Int)

class PieGraphView: UIView {
    
    private let colorSet: [UIColor] = [.brown, .blue, .red, .systemGreen, .magenta, .orange]
    weak var dataSource: PieGraphViewDateSource?
    
    var history = [Beverage]() {
        didSet {
            UIView.animate(withDuration: 1) {
                self.setNeedsDisplay()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawPieGraph()
    }
    
    private func drawPieGraph() {
        
        drawPie()
        drawTitles()
    }
    
    private func drawPie () {
        guard let dataSource = dataSource else { return }
        
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        var colorIndex = 0
        
        let numOfCategories = dataSource.numOfCategories(in: self)
        let numOfTotal = dataSource.numOfTotal(in: self)
        
        for index in 0..<numOfCategories {
            let statistic = dataSource.pieGraphView(self, statisticOfItem: index)
            endAngle += CGFloat(statistic.quantity)/CGFloat(numOfTotal) * CGFloat.pi
            
            drawPiece(color: colorSet[colorIndex % colorSet.count],
                      from: startAngle,
                      to: endAngle)
            
            startAngle = endAngle
            colorIndex += 1
        }
    }
    
    private func drawTitles () {
        guard let dataSource = dataSource else { return }
        
        var startAngle: CGFloat = 0
        var endAngle: CGFloat = 0
        
        let numOfCategories = dataSource.numOfCategories(in: self)
        let numOfTotal = dataSource.numOfTotal(in: self)
        
        for index in 0..<numOfCategories {
            let statistic = dataSource.pieGraphView(self, statisticOfItem: index)
            endAngle += CGFloat(statistic.quantity)/CGFloat(numOfTotal) * CGFloat.pi
            
            drawText(name: statistic.name,
                     from: startAngle,
                     to: endAngle)
            
            startAngle = endAngle
        }
    }
    
    private func drawPiece(color: UIColor, from startAngle: CGFloat, to endAngle: CGFloat) {
        
        let center = CGPoint(x: self.bounds.width/2,
                             y: self.bounds.height/2)
        let radius = self.bounds.width/2
        
        let path = UIBezierPath()
        
        path.move(to: center)
        path.addArc(withCenter: center,
                    radius: radius,
                    startAngle: startAngle * 2,
                    endAngle: endAngle * 2,
                    clockwise: true)
        
        path.close()
        color.setFill()
        path.stroke()
        path.fill()
    }
    
    private func drawText(name: String, from startAngle: CGFloat, to endAngle: CGFloat) {
        let center = CGPoint(x: self.bounds.width/2,
                             y: self.bounds.height/2)
        let radius = self.bounds.width/2
        
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2,
                                startAngle: startAngle * 2,
                                endAngle: startAngle + endAngle,
                                clockwise: true)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key: Any] = [ .paragraphStyle: paragraphStyle,
                                                          .font: UIFont.systemFont(ofSize: 15.0),
                                                          .foregroundColor: UIColor.white ]
        let attributedString = NSAttributedString(string: name,
                                                  attributes: attributes)
        let stringRect = CGRect(x: path.currentPoint.x - 50,
                                y: path.currentPoint.y,
                                width: 100,
                                height: 100)
        attributedString.draw(in: stringRect)
    }
}
