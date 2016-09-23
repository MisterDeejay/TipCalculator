//
//  SetLanguageViewController.swift
//  tippr
//
//  Created by Khaaliq DeJan on 9/22/16.
//  Copyright © 2016 Khaaliq DeJan. All rights reserved.
//

import UIKit

class SetLanguageViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var countryPicker: UIPickerView!
    
    let currencyKeyConstant = "currencyKey"
    let inverseColorTheme = "inverseTheme"
    var textColor = UIColor.darkTextColor()
    
    var pickerData = ["","Dollar","Euro","Yen","Sterling","Yuan","Won","Lira","Rupee","Real"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryPicker.dataSource = self
        self.countryPicker.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.boolForKey(inverseColorTheme)) {
            self.view.backgroundColor = UIColor.darkGrayColor()
            countryPicker.tintColor = UIColor.lightTextColor()
            textColor = UIColor.lightTextColor()
        } else {
            self.view.backgroundColor = UIColor.whiteColor()
            countryPicker.tintColor = UIColor.darkTextColor()
            textColor = UIColor.darkTextColor()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let string = pickerData[row]
        return NSAttributedString(string: string, attributes: [NSForegroundColorAttributeName:textColor])
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        switch row {
        case 0:
            let currentCurrencySym = defaults.objectForKey(currencyKeyConstant) as! String
            defaults.setObject(currentCurrencySym, forKey: currencyKeyConstant)
        case 1:
            defaults.setObject("$", forKey: currencyKeyConstant)
        case 2:
            defaults.setObject("€", forKey: currencyKeyConstant)
        case 3:
            defaults.setObject("¥", forKey: currencyKeyConstant)
        case 4:
            defaults.setObject("£", forKey: currencyKeyConstant)
        case 5:
            defaults.setObject("¥", forKey: currencyKeyConstant)
        case 6:
            defaults.setObject("₩", forKey: currencyKeyConstant)
        case 7:
            defaults.setObject("₺", forKey: currencyKeyConstant)
        case 8:
            defaults.setObject("₹", forKey: currencyKeyConstant)
        case 9:
            defaults.setObject("R$", forKey: currencyKeyConstant)
        default:
            defaults.setObject("$", forKey: currencyKeyConstant)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
