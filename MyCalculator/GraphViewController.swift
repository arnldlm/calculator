//
//  GraphViewController.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-19.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController, GraphViewDataSource
{
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.dataSource = self
        }
    }
    
    var scale: Int = 50 {
        didSet {
            println("Scale = \(scale)")
            updateUI()
        }
    }
    
    func updateUI() {
        graphView.setNeedsDisplay()
    }
    
    func pointsPerUnitForGraphView(sender: GraphView) -> Int? {
        return Int(scale)
    }
}
