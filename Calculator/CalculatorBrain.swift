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
    private var operations: Dictionary<String, Double> = [
        "π": Double.pi
    ]
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    func performaOperation(symbol: String) {
        switch symbol {
        case "π":
            accumulator = Double.pi
        case "√":
            accumulator = sqrt(accumulator)
        default:
            break
        }
    }
}
