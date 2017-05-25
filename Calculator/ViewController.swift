//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Lucero on 5/22/17.
//  Copyright © 2017 Jonathan Lucero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var userIsInTheMiddleOfTyping = false
    
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

    @IBAction private func performOperation(_ sender: UIButton) {
        if (userIsInTheMiddleOfTyping) {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performaOperation(symbol: mathematicalSymbol)
        }
        displayValue = brain.result
    }

}
