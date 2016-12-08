//
//  RMUtility.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit

var defaultOrangeColor = UIColor(red: 227, green: 108, blue: 28, alpha: 1.0)

func configureGlobalNavigationBarAppearence() {
    // Remove NavigationBar's border
    UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Montserrat-Bold", size: 20)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    
}

func getBase64ForImage(image : UIImage) -> String {
    let imageJPEG = UIImageJPEGRepresentation(image, 0.1)
    let imageData = imageJPEG?.base64EncodedStringWithOptions([.Encoding64CharacterLineLength])
    print("******************\(imageData?.characters.count)")
    return imageData!
}

func getImageForBase64(imageData: String) -> UIImage {
    let imageData = NSData(base64EncodedString: imageData, options: [.IgnoreUnknownCharacters])
    return UIImage(data: imageData!)!
}
