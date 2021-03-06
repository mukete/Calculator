//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mukete Mizushima on 4/23/16.
//  Copyright © 2016 Mukete Mizushima. All rights reserved.
//

import Foundation


class CalculatorBrain {
    
    private var accumulator = 0.0
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedConstantValue) :
                accumulator = associatedConstantValue
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "℮": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "±": Operation.UnaryOperation({ -$0 }),
        "cos": Operation.UnaryOperation(cos),
        "=": Operation.Equals,
        "×": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 })
        ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get {
            return accumulator
        }
    }
}