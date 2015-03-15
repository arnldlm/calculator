//
//  CalculatorBrain.swift
//  MyCalculator
//
//  Created by Arnold Lam on 2015-03-13.
//  Copyright (c) 2015 Arnold Lam. All rights reserved.
//

import Foundation

class CalculatorBrain {
    enum Op: Printable
    {
        case Operand(Double) // stores the operand (number)
        case unaryOperation(String, Double -> Double) // stores an operation and the function executing that operation
        case binaryOperation(String, (Double, Double) -> Double)
        case Variable(String) // stores the variable
        
        var description: String { // converting enum values to string
            get {
                switch self {
                    case .Operand(let operand):
                        return "\(operand)"
                    case .unaryOperation(let symbol, _):
                        return symbol
                    case .binaryOperation(let symbol, _):
                        return symbol
                    case .Variable(let symbol):
                        return "\(symbol)"
                }
            }
        }
    }
    
    var opStack = [Op]()
    var knownOps = [String:Op]()
    
    var variableValues = [String:Double]() // stores variable name and variable value
    
    init() {
        knownOps["×"] = Op.binaryOperation("×") {$0 * $1}
        knownOps["÷"] = Op.binaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.binaryOperation("+") {$0 + $1}
        knownOps["-"] = Op.binaryOperation("-") {$1 - $0}
        knownOps["√"] = Op.unaryOperation("√") {sqrt($0)}
        knownOps["sin"] = Op.unaryOperation("sin") {sin($0)}
        knownOps["cos"] = Op.unaryOperation("cos") {cos($0)}
        knownOps["tan"] = Op.unaryOperation("tan") {tan($0)}
    }
    
    //parameters: an array of type Op
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast() // pops stack and sets to var op
            switch op {
                case .Operand(let operand):
                    return(operand, remainingOps)
                case .unaryOperation(_, let operation): // case where top of stack is a unary operation
                    let operandEvaluation = evaluate(remainingOps)
                    if let operand = operandEvaluation.result {
                        return (operation(operand), operandEvaluation.remainingOps)
                    }
                case .binaryOperation(_, let operation): // case where top of stack is a binary operation
                    let op1Evaluation = evaluate(remainingOps)
                    if let operand1 = op1Evaluation.result {
                        let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                        if let operand2 = op2Evaluation.result {
                            return(operation(operand1, operand2), op2Evaluation.remainingOps)
                        }
                    }
                case .Variable(let symbol):
                    if let variableValue = variableValues["\(symbol)"] {
                        return (variableValue, remainingOps)
                    }
            }
            
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(opStack)
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol:String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        
        return evaluate()
    }
    
    func pushOperand(symbol: String) -> Double? {
        opStack.append(Op.Variable(symbol))
        return evaluate()
    }
}
