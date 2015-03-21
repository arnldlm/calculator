//
//  GraphView.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-19.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import UIKit

protocol GraphViewDataSource: class {
    func pointsPerUnitForGraphView(sender: GraphView) -> Int?
}

@IBDesignable

class GraphView: UIView {

    weak var dataSource: GraphViewDataSource? // Of type protocol
    
    var drawer = AxesDrawer()

    override func drawRect(rect: CGRect) {
        let scale = dataSource?.pointsPerUnitForGraphView(self) ?? 0
        drawer.drawAxesInRect(bounds, origin: center, pointsPerUnit: CGFloat(scale))
    }
}
