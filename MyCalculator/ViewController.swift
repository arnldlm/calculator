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
    
    var brain = CalculatorBrain()
    
    @IBOutlet weak var stack: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var buttonSetM: UIButton!
    
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
        if brain.opStack.count >= 2 {
            sendOperateToBrain(sender.currentTitle!)
        }
        printOntoStack()
    }
    
    @IBAction func unaryOperate(sender: UIButton) {
        if userIsTyping {
            enter()
        }
        if brain.opStack.count >= 1 {
            sendOperateToBrain(sender.currentTitle!)
        }
        printOntoStack()
    }
    
    
    func sendOperateToBrain(op: String?) {
        if let operation = op {
            if let result = brain.performOperation(operation) {
                displayValue = result
            }
        else {
            displayValue = 0
        }
        }
    }
    
    @IBAction func enter() {
        let text = display.text!
        if text != "M" {
            userIsTyping = false
            if let result = brain.pushOperand(displayValue) {
                displayValue = result
            } else {
                displayValue = 0
            }
            printOntoStack()
        }
    }

    @IBAction func clear() {
        display.text = "0"
        userIsTyping = false
        decimalTyped = false
        
        brain = CalculatorBrain()
        
        stack.text = nil
        buttonSetM.enabled = true
    }
    
    @IBAction func setVariable() {
        if brain.variableValues.isEmpty {
            brain.pushOperand("M")
            let variableValue = displayValue
            brain.variableValues["M"] = variableValue
            display.text = "M = \(variableValue)"
            userIsTyping = false
            
            buttonSetM.titleLabel!.textColor = UIColor.yellowColor()
            buttonSetM.enabled = false
        }
        printOntoStack()
    }
    
    @IBAction func variable_x() {
        if !brain.variableValues.isEmpty {
            displayValue = brain.variableValues["M"]!
        }
        else {
            display.text = "M"
            userIsTyping = false
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
    
    func printOntoStack() {
        stack.text = "\(brain.opStack)"
    }
    
}

