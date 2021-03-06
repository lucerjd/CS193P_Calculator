//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Lucero on 5/22/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var displayValue: Double {
        get {
            if (display.text! == ".") {
                return 0.0
            }
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var userIsInTheMiddleOfTyping = false
    private var alreadyTouchedPeriod = false
    
    private var brain = CalculatorBrain()
    
    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }

    @IBAction func touchPeriod(_ sender: UIButton) {
        if (alreadyTouchedPeriod) {
            //Do Nothing
        }
        else {
            alreadyTouchedPeriod = true
            touchDigit(sender)
        }
    }
    
    @IBAction func touchClear(_ sender: UIButton) {
        userIsInTheMiddleOfTyping = false
        alreadyTouchedPeriod = false
        display.text! = "0"
        brain.resetCalculatorState()
        
    }
    
    @IBAction func touchMemoryAdd(_ sender: UIButton) {
        brain.memoryAdd(operand: displayValue)
    }
    
    @IBAction func touchMemoryRemove(_ sender: UIButton) {
        display.text! = String(brain.memoryRemove())
        brain.setOperand(operand: displayValue)
        userIsInTheMiddleOfTyping = false
        displayValue = brain.result
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if (userIsInTheMiddleOfTyping) {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
            alreadyTouchedPeriod = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }

}
