//
//  ViewController.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-13.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var userIsTyping = false
    var decimalTyped = false
    var piTyped = false
    
    var brain = CalculatorBrain()
    
    @IBOutlet weak var stack: UILabel!
    
    @IBOutlet weak var display: UILabel!
    
    @IBAction func numInput(sender: UIButton) {
        let digit = sender.currentTitle
        if userIsTyping {
            switch digit! {
                case ".":
                    if !decimalTyped {
                        display.text = display.text! + digit!
                        decimalTyped = true
                    }
                default:
                    display.text = display.text! + digit!

            }
        }
        else {
            switch digit! {
                case ".":
                    if !decimalTyped {
                        display.text = digit
                    }
                default:
                    display.text = digit!
            }

            userIsTyping = true
        }
    }
    
    @IBAction func operate(sender: AnyObject) {
        if userIsTyping {
            enter()
        }
        
        if let operation = sender.currentTitle! {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
            else {
                displayValue = 0
            }
        }
    }
    
    @IBAction func enter() {
        userIsTyping = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
        stack.text = "\(brain.opStack)"
    }

    @IBAction func clear() {
        display.text = "0"
        userIsTyping = false
        decimalTyped = false
        piTyped = false
        
        brain = CalculatorBrain()
    }
    
    @IBAction func variable_x() {
        if brain.variableValues.isEmpty {
            brain.pushOperand("x")
            let variableValue = displayValue
            brain.variableValues["x"] = variableValue
            
            display.text = "x = \(variableValue)"
            userIsTyping = false
        }
        else {
            displayValue = brain.variableValues["x"]!
        }
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsTyping = false
        }
    }
    
    
}

