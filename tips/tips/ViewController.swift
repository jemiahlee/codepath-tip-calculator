//
//  ViewController.swift
//  tips
//
//  Created by Jeremiah Lee on 1/9/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!

    @IBOutlet weak var tipControl: UISegmentedControl!

    let appConfig = AppConfig.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billField.becomeFirstResponder()

        self.navigationController!.delegate = self

        loadTipData()
    }

    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        loadTipData()
        recalculateTip()
    }

    func loadTipData() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("tipSelection") != nil {
            tipControl.selectedSegmentIndex = defaults.integerForKey("tipSelection")
        }

        if defaults.objectForKey("firstTip") != nil {
            let first_segment_text = defaults.stringForKey("firstTip")!
            tipControl.setTitle("\(first_segment_text)%", forSegmentAtIndex: 0)
            appConfig.firstTip = Int(first_segment_text)
        } else {
            tipControl.setTitle("15%", forSegmentAtIndex: 0)
            appConfig.firstTip = 15
        }

        if defaults.objectForKey("secondTip") != nil {
            let second_segment_text = defaults.stringForKey("secondTip")!
            tipControl.setTitle("\(second_segment_text)%", forSegmentAtIndex: 1)
            appConfig.secondTip = Int(second_segment_text)
        } else {
            tipControl.setTitle("18%", forSegmentAtIndex: 1)
            appConfig.secondTip = 18
        }

        if defaults.objectForKey("thirdTip") != nil {
            let third_segment_text = defaults.stringForKey("thirdTip")!
            tipControl.setTitle("\(third_segment_text)%", forSegmentAtIndex: 2)
            appConfig.thirdTip = Int(third_segment_text)
        } else {
            tipControl.setTitle("20%", forSegmentAtIndex: 2)
            appConfig.thirdTip = 20
        }

        if defaults.objectForKey("fourthTip") != nil {
            let fourth_segment_text = defaults.stringForKey("fourthTip")!
            tipControl.setTitle("\(fourth_segment_text)%", forSegmentAtIndex: 3)
            appConfig.fourthTip = Int(fourth_segment_text)
        } else {
            tipControl.setTitle("22%", forSegmentAtIndex: 3)
            appConfig.fourthTip = 22
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getTipPercentages() -> [Double] {
        var percentages: [Double] = [Double]()
        for field in [appConfig.firstTip!, appConfig.secondTip!, appConfig.thirdTip!, appConfig.fourthTip!] {
            percentages.append(Double(field) / 100.0)
        }
        return percentages
    }

    func recalculateTip() {
        var billAmount = 0.0
        var tipPercentages = getTipPercentages()
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

