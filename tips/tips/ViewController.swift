//
//  ViewController.swift
//  tips
//
//  Created by Jeremiah Lee on 1/9/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()

        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("tipSelection") != nil {
            tipControl.selectedSegmentIndex = defaults.integerForKey("tipSelection")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func recalculateTip() {
        var billAmount = 0.0
        var tipPercentages = [0.15, 0.18, 0.20, 0.22]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]

        let billFieldValue = billField.text
        if billFieldValue != nil {
            billAmount = billFieldValue!._bridgeToObjectiveC().doubleValue
        }

        let tip = billAmount * tipPercentage
        let total = billAmount + tip

        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        tipLabel.text = formatter.stringFromNumber(tip)!
        totalLabel.text = formatter.stringFromNumber(total)!
    }

    @IBAction func tipChoiceChanged(sender: AnyObject) {
        recalculateTip()

        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: "tipSelection")
    }

    @IBAction func billFieldChanged(sender: AnyObject) {
        recalculateTip()
    }
}

