//
//  RMInvoice.swift
//  roomate
//
//  Created by Corey Pett on 11/30/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import BraintreeDropIn
import PassKit

let testToken = "REDACTED_BRAINTREE_SANDBOX_TOKEN"

struct RMInvoice {
   // var total: Double?
    var total: Double?
    var title: String?
    var category: String?
    var debtors: [String : Double]?
    
    // MARK: - BrainTree DropInUI
    
    func fetchClientToken(viewController: UIViewController) {
        let clientTokenURL = NSURL(string: "https://braintree-sample-merchant.herokuapp.com/client_token")!
        let clientTokenRequest = NSMutableURLRequest(URL: clientTokenURL as NSURL)
        clientTokenRequest.setValue("text/plain", forHTTPHeaderField: "Accept")
        
        NSURLSession.sharedSession().dataTaskWithRequest(clientTokenRequest as NSURLRequest){ (data, response, error) -> Void in
            // TODO: Handle errors
             let clientToken = String(data: data!, encoding: NSUTF8StringEncoding)
            
            self.showDropIn(testToken, viewController: viewController)
            
            }.resume()
        }
    
    private func showDropIn(clientTokenOrTokenizationKey: String, viewController: UIViewController) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.cancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                // result.paymentOptionType
                // result.paymentMethod
                // result.paymentIcon
                // result.paymentDescription
            }
            controller.dismissViewControllerAnimated(true, completion: nil)
        }
        viewController.presentViewController(dropIn!, animated: true, completion: nil)
    }
    
    // MARK: - BrainTree Apple Pay
    
    func paymentRequest(itemDescription: String, cost: String) -> PKPaymentRequest {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.com.ru.roomate";
        paymentRequest.supportedNetworks = [PKPaymentNetworkAmex, PKPaymentNetworkVisa, PKPaymentNetworkMasterCard];
        paymentRequest.merchantCapabilities = PKMerchantCapability.Capability3DS;
        paymentRequest.countryCode = "US"; // e.g. US
        paymentRequest.currencyCode = "USD"; // e.g. USD
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: itemDescription, amount: NSDecimalNumber(string: cost)),
            // Add payment summary items...
            //PKPaymentSummaryItem(label: "<#COMPANY_NAME#>", amount: NSDecimalNumber(string: "<#GRAND_TOTAL#>"))
        ]
        return paymentRequest
    }
}
