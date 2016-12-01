//
//  RMUtility.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit

func configureGlobalNavigationBarAppearence() {
    // Remove NavigationBar's border
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeue-Thin", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
}
