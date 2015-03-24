//
//  GraphViewController.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-19.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController
{
    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "scale:"))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
