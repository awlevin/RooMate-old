//
//  RMFinanceBill.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMFinanceBill {
    var objectId: String
    var dateCreatedAt: String
    var dateUpdatedAt: String
    var paymentRecipient: String
    var totalAmountOwed: Double
    var paymentTitle: String
    var category: String
    var description: String
    var debtors: [RMUser : Double]
    
    
    // Public Functions
    
    public func generateUserBill(userId: String) -> RMFinanceBill {
        
    }
    
    public func generateABill(groupId: String) -> RMFinanceBill{
        
    }
    
    public func remindUser(user: String) {
        
    }
    
    public func remindAllUsers(users: [String]) {
        // Consider modifying the parameters of this function.
        // If it should remind all users, it shouldn't need to be passed a list of those users.
        // Maybe we should create a separate method, called "remindMultipleUsers" where the method
            // caller can specify the users to remind.
    }
    
    public func updateAmountDue(newBalanceSheet: [RMUser : Double]) {
        
    }
    
    
    // Private Functions
    
    private func calculateAmountDue(percentage: Double) -> Double {
    
    }
}
