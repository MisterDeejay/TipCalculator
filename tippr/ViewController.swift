//
//  ViewController.swift
//  tippr
//
//  Created by Khaaliq DeJan on 9/22/16.
//  Copyright © 2016 Khaaliq DeJan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    @IBOutlet weak var tipCalcView: UIView!
    
    // viewWillAppear callback is used to customize the animation
    // when the TipCalculator screen appears
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, animations: {
            self.tipCalcView.alpha = 1
        })
        
        let defaults = NSUserDefaults.standardUserDefaults()
        tipSelector.selectedSegmentIndex = defaults.integerForKey("defaultTip")
        
        calculateTip(self)
    }

    // onTap closes the keyboard when the user taps anywhere on the
    // screen
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    // calculateTip uses the active index on the UISegmentedControl
    // to calculate and updates the display of both the tip amount
    // and the total
    @IBAction func calculateTip(sender: AnyObject) {
        let tipPercentages = [0.15, 0.18, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipSelector.selectedSegmentIndex]
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

