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
    
    let defaultTipKeyConstant = "defaultTip"
    let billKeyConstant = "bill"
    let dateBillSavedKeyConstant = "savedAt"
    let currencyKeyConstant = "currencyKey"
    
    // viewWillAppear callback is used to customize the animation
    // when the TipCalculator screen appears, sets the tip percentage to the 
    // value stored in defaults and sets the billField to the last value
    // that was there if less than 3 minutes has passed
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, animations: {
            self.tipCalcView.alpha = 1
        })
        
        let defaults = getDefaults()
        let idx = defaults.integerForKey(defaultTipKeyConstant)
        setTipPercentage(idx)
        
        let billSavedAt = defaults.objectForKey(dateBillSavedKeyConstant)
        if (billSavedAt != nil) {
            let billAmt = defaults.doubleForKey(billKeyConstant)
            setBillField((billSavedAt as! NSDate), billAmt: billAmt)
        }
        
        calculateTip(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        checkForAndSetSavedCurrencySym()
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
        saveBillAndTime(bill)
        
        let tip = bill * tipPercentages[tipSelector.selectedSegmentIndex]
        let total = tip + bill
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        checkForAndSetSavedCurrencySym()
    }
    
    func saveBillAndTime(amt: Double) {
        let defaults = getDefaults()
        defaults.setDouble(amt, forKey: billKeyConstant)
        defaults.setObject(NSDate(), forKey: dateBillSavedKeyConstant)
    }
    
    private func getDefaults() -> AnyObject {
        return NSUserDefaults.standardUserDefaults()
    }
    
    /* setBillField sets the value of the TextField object on the screen
     with the value stored in the defaults only if the time elasped since
     the last time that amount was saved is less that 3 minutes and that 
     value is greater than 0
     
     @param savedAt The last time the value in billField was saved
     @param billAmt The last value of billField saved in defaults */
    private func setBillField(savedAt: NSDate, billAmt: Double) {
        let minElapsed = savedAt.timeIntervalSinceNow / 60.0
        if (minElapsed < 3.0 && billAmt > 0.0) {
            billField.text = String(format: "%.2f", billAmt)
        }
    }
    
    /* setTipPercentage reads the value of the defautTip key in the defaults
     and uses that value as the index of the UISegmentedControl that is 
     selected when the View first appears. If there is no value for the key
     in the defaults, then it by default be set to 0. 
     
     @param: idx The index used to select the UISegmentedControl */
    private func setTipPercentage(idx: Int) {
        tipSelector.selectedSegmentIndex = idx
    }
    
    private func fetchLocaleLang() -> String {
        return NSBundle.mainBundle().preferredLocalizations.first! as String
    }
    
    private func setCurrencySym(sym: String) {
        let tipLabelStr = tipLabel.text!
        let totalLabelStr = totalLabel.text!

        tipLabel.text = tipLabelStr.stringByReplacingCharactersInRange(tipLabelStr.startIndex...tipLabelStr.startIndex, withString: sym)
        totalLabel.text = totalLabelStr.stringByReplacingCharactersInRange(totalLabelStr.startIndex...totalLabelStr.startIndex, withString: sym)
    }
    
    /* checkForandSetSavedCurrencySym checks the defaults for a currency symbol to 
     use, if there isn't one it uses the language settings in the phone to picked a 
     currency symbol is the language is supported or defaults to the dollar ($) symbol
     */
    private func checkForAndSetSavedCurrencySym() {
        let defaults = getDefaults()
        
        if ((defaults.objectForKey(currencyKeyConstant) != nil)) {
            let currencySym = defaults.objectForKey(currencyKeyConstant) as! String
            setCurrencySym(currencySym)
        } else {
            let lang = fetchLocaleLang()
            let localeCurrencySym = convertLangToCurrency(lang)
            setCurrencySym(localeCurrencySym)
        }
    }
    
    /* convertLangToCurrency takes in the 2 letter language locale code taken from the
     phone's settings and returns the most commonly used currency symbol for that 
     language, if supported */
    private func convertLangToCurrency(lang: String) -> String {
        switch lang {
            case "ja":
                return "¥"
            case "pt":
                return "R$"
            case "zh":
                return "¥"
            case "ko":
                return "₩"
            case "tr":
                return "₺"
            case "hi":
                return "₹"
            case "de",
                 "nl",
                 "fr",
                 "el",
                 "et",
                 "fi",
                 "sv",
                 "ga",
                 "it",
                 "lv",
                 "lt",
                 "lb",
                 "mt",
                 "fy",
                 "sk",
                 "sl":
                return "€"
            default:
                return "$"
        }
    }
}

