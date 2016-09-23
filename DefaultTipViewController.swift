//
//  DefaultTipViewController.swift
//  tippr
//
//  Created by Khaaliq DeJan on 9/22/16.
//  Copyright © 2016 Khaaliq DeJan. All rights reserved.
//

import UIKit

class DefaultTipViewController: UIViewController {

    @IBOutlet weak var defaultTipSelector: UISegmentedControl!
    
    let defaultTipKeyConstant = "defaultTip"
    let inverseColorTheme = "inverseTheme"
    
    // viewWillAppear callback loads the value for the defaultTip and
    // uses it to select the default tip percentage stored the
    // user has stored in memory
    override func viewWillAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaultTipSelector.selectedSegmentIndex = defaults.integerForKey(defaultTipKeyConstant)
        setAndCheckColorThem()
    }
    
    // saveDefaultTip saves the value of the index that is
    // currently selected in the UISegmentedControl
    @IBAction func saveDefaultTip(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSelector.selectedSegmentIndex, forKey: defaultTipKeyConstant)
        defaults.synchronize()
    }
    
    private func setAndCheckColorThem() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.boolForKey(inverseColorTheme)) {
            defaultTipSelector.tintColor = UIColor.yellowColor()
            self.view.backgroundColor = UIColor.darkGrayColor()
        } else {
            defaultTipSelector.tintColor = UIColor.blueColor()
            self.view.backgroundColor = UIColor.whiteColor()
        }
    }
}
