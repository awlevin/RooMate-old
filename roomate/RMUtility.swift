//
//  RMUtility.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit

var defaultOrangeColor = UIColor(red: 232.0, green: 128.0, blue: 50.0, alpha: 1.0)

func configureGlobalNavigationBarAppearence() {
    // Remove NavigationBar's border
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Montserrat-Bold", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
}
