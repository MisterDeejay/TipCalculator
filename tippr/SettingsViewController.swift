//
//  SettingsViewController.swift
//  tippr
//
//  Created by Khaaliq DeJan on 9/22/16.
//  Copyright © 2016 Khaaliq DeJan. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    
    let inverseColorTheme = "inverseTheme"
    
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let invertedColorTheme = defaults.boolForKey(inverseColorTheme)
        if(invertedColorTheme) {
            label1.textColor = UIColor.lightTextColor()
            label2.textColor = UIColor.lightTextColor()
            label3.textColor = UIColor.lightTextColor()
            cell1.backgroundColor = UIColor.blackColor()
            cell2.backgroundColor = UIColor.blackColor()
            cell3.backgroundColor = UIColor.blackColor()
            self.view.backgroundColor = UIColor.darkGrayColor()
        } else {
            label1.textColor = UIColor.darkTextColor()
            label2.textColor = UIColor.darkTextColor()
            label3.textColor = UIColor.darkTextColor()
            cell1.backgroundColor = UIColor.whiteColor()
            cell2.backgroundColor = UIColor.whiteColor()
            cell3.backgroundColor = UIColor.whiteColor()
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
}