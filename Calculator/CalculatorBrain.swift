//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jonathan Lucero on 5/25/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import Foundation

class CalculatorBrain {
    var result: Double {
        get {
            return accumulator
        }
    }
    
    private var accumulator = 0.0
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "cos": Operation.UnaryOperation(cos),
        "+" : Operation.BinaryOperation({ $0 + $1}),
        "−" : Operation.BinaryOperation({ $0 - $1}),
        "×" : Operation.BinaryOperation({ $0 * $1}),
        "÷" : Operation.BinaryOperation({ $0 / $1}),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performOperation(symbol: String) {
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function) :
                accumulator = function(accumulator)
            case .BinaryOperation(let function) :
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals :
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
}
