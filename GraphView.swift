//
//  GraphView.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-19.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import UIKit

protocol delegate: class {
    func equationForGraphView(sender: GraphView) -> String?
}

@IBDesignable
class GraphView: UIView {

    @IBInspectable
    var graphScale: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    weak var dataSource: delegate?
    
    var drawer = AxesDrawer()

    override func drawRect(rect: CGRect) {
        drawer.drawAxesInRect(bounds, origin: center, pointsPerUnit: graphScale)
        
        let equation = dataSource?.equationForGraphView(self) ?? "Failed to obtain equation"
        println(equation)
    }
    
    func scale (gesture: UIPinchGestureRecognizer) { // Pinch gesture
        if gesture.state == .Changed {
            graphScale *= gesture.scale
            gesture.scale = 1 // resets back to 1 continuously update scale
        }
    }
}
