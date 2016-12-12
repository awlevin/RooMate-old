//
//  RMExtensions.swift
//  roomate
//
//  Created by Corey Pett on 11/29/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit

extension NSDate {
    func getCurrentTimeAndDate() -> String {
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateStyle = NSDateFormatterStyle.LongStyle
        dateFormat.timeStyle = NSDateFormatterStyle.MediumStyle
        
        return dateFormat.stringFromDate(self)
        
        /*
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        let hour = calendar.component(.Hour, fromDate: date)
        let minutes = calendar.component(.Minute, fromDate: date)
        let seconds = calendar.component(.Second, fromDate: date)
        
        return "\(date.description) - \(hour):\(minutes):\(seconds)"
        */
    }
}

extension Double {
    var asLocaleCurrency:String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale.currentLocale()
        return formatter.stringFromNumber(self)!
    }
}

extension UIImageView {
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UIButton {
    func setRounded() {
        let radius = CGRectGetWidth(self.frame) / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let imageData = data as NSData? {
                    self.image = UIImage(data: imageData)
                }
            }
        }
    }
}
