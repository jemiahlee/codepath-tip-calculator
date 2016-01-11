//
//  SettingsViewController.swift
//  tips
//
//  Created by Jeremiah Lee on 1/10/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstTipField: UITextField!
    @IBOutlet weak var secondTipField: UITextField!
    @IBOutlet weak var thirdTipField: UITextField!
    @IBOutlet weak var fourthTipField: UITextField!

    let appConfig = AppConfig.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        firstTipField.delegate = self
        secondTipField.delegate = self
        thirdTipField.delegate = self
        fourthTipField.delegate = self

        if appConfig.firstTip != nil {
            firstTipField.text = "\(appConfig.firstTip!)"
        }

        if appConfig.secondTip != nil {
            secondTipField.text = "\(appConfig.secondTip!)"
        }

        if appConfig.thirdTip != nil {
            thirdTipField.text = "\(appConfig.thirdTip!)"
        }

        if appConfig.fourthTip != nil {
            fourthTipField.text = "\(appConfig.fourthTip!)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("Segue function was called")
        saveFields()
    }

    func saveFields() {
        let defaults = NSUserDefaults.standardUserDefaults()

        if firstTipField.text != nil && firstTipField.text! != "" {
            defaults.setInteger(Int(firstTipField.text!)!, forKey: "firstTip")
            appConfig.firstTip = Int(firstTipField.text!)
            print("Saving firstTip as \(firstTipField.text!)")
        } else {
            defaults.setInteger(15, forKey: "firstTip")
        }

        if secondTipField.text != nil && secondTipField.text! != "" {
            defaults.setInteger(Int(secondTipField.text!)!, forKey: "secondTip")
            appConfig.secondTip = Int(secondTipField.text!)
        } else {
            defaults.setInteger(18, forKey: "secondTip")
        }

        if thirdTipField.text != nil && thirdTipField.text! != "" {
            defaults.setInteger(Int(thirdTipField.text!)!, forKey: "thirdTip")
            appConfig.thirdTip = Int(thirdTipField.text!)
        } else {
            defaults.setInteger(20, forKey: "thirdTip")
        }

        if fourthTipField.text != nil && thirdTipField.text! != "" {
            defaults.setInteger(Int(fourthTipField.text!)!, forKey: "fourthTip")
            appConfig.fourthTip = Int(fourthTipField.text!)
        } else {
            defaults.setInteger(22, forKey: "fourthTip")
        }
    }

    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {


        let currentText = textField.text ?? ""
        // let range = NSMakeRange(0, currentText.characters.count)
        let prospectiveText = (currentText as NSString).stringByReplacingCharactersInRange(range, withString: string)

        if string.characters.count == 0 {
            return true
        }

        if prospectiveText == "" {
            return true
        }

        let regex = try! NSRegularExpression(pattern: "[^\\d]", options: NSRegularExpressionOptions())
        if regex.numberOfMatchesInString(string, options: [], range: NSMakeRange(0, 1)) > 0 {
            return false
        }

        print("prospectiveText was \(prospectiveText)")

        if Int(prospectiveText) > 100 {
            print("prospectiveText was over 100, returning false")
            return false
        }

        return true
    }

    @IBAction func firstTipModified(sender: AnyObject) {
        saveFields()
    }
}
