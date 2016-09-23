//
//  SetColorThemeViewController.swift
//  tippr
//
//  Created by Khaaliq DeJan on 9/23/16.
//  Copyright © 2016 Khaaliq DeJan. All rights reserved.
//

import UIKit

class SetColorThemeViewController: UIViewController {
    
    @IBOutlet weak var invertColorThemeSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    let inverseColorTheme = "inverseTheme"

    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let invertedColorTheme = defaults.boolForKey(inverseColorTheme)
        invertColorThemeSwitch.on = invertedColorTheme
        checkAndInvertColors()
    }

    @IBAction func setInvertedColorTheme(sender: AnyObject) {
        checkAndInvertColors()
        saveColorTheme(invertColorThemeSwitch.on)
    }
    
    private func checkAndInvertColors() {
        if(invertColorThemeSwitch.on) {
            switchLabel.textColor = UIColor.lightTextColor()
            self.view.backgroundColor = UIColor.darkGrayColor()
        } else {
            switchLabel.textColor = UIColor.darkTextColor()
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
    
    private func saveColorTheme(bool: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(bool, forKey: inverseColorTheme)
    }
}
