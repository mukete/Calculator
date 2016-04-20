//
//  ViewController.swift
//  Calculator
//
//  Created by Mukete Mizushima on 4/20/16.
//  Copyright © 2016 Mukete Mizushima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsTypingSomething: Bool = false

    @IBAction func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if(userIsTypingSomething){
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsTypingSomething = true
    }

    @IBAction func performOperation(sender: UIButton) {
        userIsTypingSomething = false
        if let mathSymbol = sender.currentTitle {
            if mathSymbol == "Pi" {
                display.text = String(M_PI)
            }
        }
    }
}

