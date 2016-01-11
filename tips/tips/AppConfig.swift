//
//  AppConfig.swift
//  tips
//
//  Created by Jeremiah Lee on 1/10/16.
//  Copyright © 2016 Jeremiah Lee. All rights reserved.
//

import Foundation

class AppConfig {
    class var sharedInstance: AppConfig {
        struct Static {
            static var instance: AppConfig?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = AppConfig()
        }

        return Static.instance!
    }

    var firstTip: Int?
    var secondTip: Int?
    var thirdTip: Int?
    var fourthTip: Int?
}