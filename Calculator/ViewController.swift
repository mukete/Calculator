//
//  ViewController.swift
//  Calculator
//
//  Created by Mukete Mizushima on 4/20/16.
//  Copyright © 2016 Mukete Mizushima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsTypingSomething: Bool = false

    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsTypingSomething){
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTypingSomething = true
    }
    
    private var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    private var brain = CalculatorBrain()

    @IBAction private func performOperation(sender: UIButton) {
        if(userIsTypingSomething){
            brain.setOperand(displayValue)
            userIsTypingSomething = false
        }
        
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(mathSymbol)
        }
        
        displayValue = brain.result
    }
}

