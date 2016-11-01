//
//  RMNotificationManager.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation


// Enum Declarations

public enum RMPushTypes {
    case Message
    case BulletinBoard
    case FinanceBill
    case Chore
    case GroceryShopping
    case CommunalGrocery
}

public enum RMTabTypes {
    case AppIcon
    case BulletinBoard
    case Finance
    case Grocery
    case Chore
    case Settings
}



// Public Functions

public func sendPushNotificationToUser(user: String, message: String) {
    // should this return something on success vs. failure?
}

public func incremementBadgeOn(tab: RMTabTypes) {
    
}
