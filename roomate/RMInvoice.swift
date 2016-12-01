//
//  RMInvoice.swift
//  roomate
//
//  Created by Corey Pett on 11/30/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

protocol InvoiceDelegate {
    func invoiceTotalEdited(total: Double)
}

struct RMInvoice {
   // var total: Double?
    var total: Double? {
        get {
            return self.total
        }
        set {
            delegate?.invoiceTotalEdited(newValue!)
        }
    }
    var title: String?
    var category: String?
    var delegate:InvoiceDelegate?
    var debtors: [String : Int]?
}
