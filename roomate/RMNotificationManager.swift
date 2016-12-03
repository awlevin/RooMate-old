//
//  RMNotificationManager.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit
import OneSignal


// Enum Declarations

public enum RMPushTypes {
    case NewBulletinPostCreated
    case NewBulletinCommentCreated
    case NewDebtCreated
    case DebtCancelled
    case DebtPaid
    case ChoreCompleted
    case NewChoreCreated
    case RoomateShoopping
    case NewCommunalGrocery
}

public enum RMTabTypes {
    case BulletinBoard
    case Finance
    case Shopping
    case Chore
    case Settings
    case AppIcon
}



struct RMNotificationManger {
    /**
    
     Present a simple alert view controller with a title and message
     
    */
    func presentSimpleAlertWithMessage(title:String, message:String, viewController:UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: nil))
        viewController.presentViewController(viewController, animated: true, completion: nil)
    }
        
    /**
     
     Reset badge count for a DSTabType
     
     */
    
    func removeBadgeOn(tab: RMTabTypes, tabBarController: UITabBarController) {
        switch tab {
        case .BulletinBoard:
            tabBarController.tabBar.items?[0].badgeValue = nil
            return
        case .Finance:
            tabBarController.tabBar.items?[1].badgeValue = nil
        case .Shopping:
            tabBarController.tabBar.items?[2].badgeValue = nil
            return
        case .Chore:
            tabBarController.tabBar.items?[3].badgeValue = nil
        case .Settings:
            tabBarController.tabBar.items?[4].badgeValue = nil
        case .AppIcon:
            UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        }
    }
    
    /**
     Sends a push notification to another user.
     Must use the user's oneSignalId which is a property of a DSUser
     
     - Parameter userId: OneSignal user's id
     - Parameter message: The message the user wants to send to the other user
     
     */
    
    func sentPushTo(userId: String, message: String, pushType: RMPushTypes) {        
        switch pushType {
        case .NewBulletinPostCreated:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "New Bulletin Post!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .NewBulletinCommentCreated:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "New Comment!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .NewDebtCreated:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "New Cost!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .DebtPaid:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "Debt Paid!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .DebtCancelled:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "Debt Cancelled!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .NewChoreCreated:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "New Chore Created!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .ChoreCompleted:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "Chore Completed!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .NewCommunalGrocery:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "New Grocery Added!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        case .RoomateShoopping:
            OneSignal.postNotification(["contents": ["en": message],
                                        "headings": ["en" : "RooMate Is Going Shopping!"],
                                        "include_player_ids": [userId],
                                        "ios_badgeType": "Increase",
                                        "ios_badgeCount": 1])
            break
        }
    }
    
    /**
     
     Initialize and configure push notifications, should be called in AppDelegate. Push notifications will be handled through here
     
     - Parameter launchOptions: UIApplication launch options found in the AppDelegate
     
     */
    
    func configure(launchOptions: [NSObject : AnyObject]!) {
        OneSignal.initWithLaunchOptions(launchOptions, appId: "6f212add-742d-4149-a76d-e9883854bf75", handleNotificationReceived: { (notification) in
            
            // This block gets called when the user has the app open
            
            print("Received Notification - \(notification?.payload.notificationID)")
            
            let payload = notification?.payload
            
            // Handle push notification
            if let title = payload?.title {
                switch title {
                case "New Bulletin Post!":
                        self.didRecievePush(.NewBulletinPostCreated)
                    return
                case "New Comment!":
                        self.didRecievePush(.NewBulletinCommentCreated)
                    return
                case "New Cost!":
                        self.didRecievePush(.NewDebtCreated)
                    return
                case "Debt Paid!":
                        self.didRecievePush(.DebtPaid)
                    return
                case "Debt Cancelled!":
                        self.didRecievePush(.DebtCancelled)
                    return
                case "New Chore Created!":
                        self.didRecievePush(.NewChoreCreated)
                    return
                case "Chore Completed!":
                        self.didRecievePush(.ChoreCompleted)
                    return
                case "New Grocery Added!":
                        self.didRecievePush(.NewCommunalGrocery)
                    return
                case "RooMate Is Going Shopping!":
                        self.didRecievePush(.RoomateShoopping)
                    return
                default:
                    return
                }
            }
        
            
            }, handleNotificationAction: { (result) in
                
                // This block gets called when the user reacts to a notification received
                
                // **TODO**  Open proper viewControllers accordingly
                let payload = result?.notification.payload
                
                // Handle push notification
                if let title = payload?.title {
                    switch title {
                    case "New Bulletin Post!":
                        self.didRecievePush(.NewBulletinPostCreated)
                        return
                    case "New Comment!":
                        self.didRecievePush(.NewBulletinCommentCreated)
                        return
                    case "New Cost!":
                        self.didRecievePush(.NewDebtCreated)
                        return
                    case "Debt Paid!":
                        self.didRecievePush(.DebtPaid)
                        return
                    case "Debt Cancelled!":
                        self.didRecievePush(.DebtCancelled)
                        return
                    case "New Chore Created!":
                        self.didRecievePush(.NewChoreCreated)
                        return
                    case "Chore Completed!":
                        self.didRecievePush(.ChoreCompleted)
                        return
                    case "New Grocery Added!":
                        self.didRecievePush(.NewCommunalGrocery)
                        return
                    case "RooMate Is Going Shopping!":
                        self.didRecievePush(.RoomateShoopping)
                        return
                    default:
                        return
                    }
                }
  
            }, settings: [kOSSettingsKeyAutoPrompt : true, kOSSettingsKeyInAppAlerts : false])
        
    }
    
    /**
     
     Prompt user to register for push notifications. Does not to be used if configure is called.
     
     */
    
    func registerForPushNotifications() {
        OneSignal.registerForPushNotifications()
    }
}

// MARK: - Private Functions

private extension RMNotificationManger {
    func didRecievePush(pushType: RMPushTypes) {
        switch pushType {
        case .NewBulletinPostCreated:

            break
        case .NewBulletinCommentCreated:

            break
        case .NewDebtCreated:

            break
        case .DebtPaid:

            break
        case .DebtCancelled:

            break
        case .NewChoreCreated:

            break
        case .ChoreCompleted:

            break
        case .NewCommunalGrocery:

            break
        case .RoomateShoopping:

            break
        }
    }
    
    /**
     TODO - Once the tab bar items are in place, we need to switch the array numbers around
     
     Add badge to a tab in the TabBarController or add a badge to the app icon
     */
    
    func incrementBadgeOn(tab: RMTabTypes, tabBarController: UITabBarController?) {
        switch tab {
        case .BulletinBoard:
            if var badgeValue = tabBarController?.tabBar.items?[0].badgeValue {
                let value = Int(badgeValue)! + 1
                badgeValue = String(value)
            } else {
                tabBarController?.tabBar.items?[0].badgeValue = "1"
            }
            return
        case .Chore:
            if var badgeValue = tabBarController?.tabBar.items?[1].badgeValue {
                let value = Int(badgeValue)! + 1
                badgeValue = String(value)
            } else {
                tabBarController?.tabBar.items?[1].badgeValue = "1"
            }
        case .Finance:
            if var badgeValue = tabBarController?.tabBar.items?[2].badgeValue {
                let value = Int(badgeValue)! + 1
                badgeValue = String(value)
            } else {
                tabBarController?.tabBar.items?[2].badgeValue = "1"
            }
            return
        case .Shopping:
            if var badgeValue = tabBarController?.tabBar.items?[3].badgeValue {
                let value = Int(badgeValue)! + 1
                badgeValue = String(value)
            } else {
                tabBarController?.tabBar.items?[3].badgeValue = "1"
            }
        case .Settings:
            if var badgeValue = tabBarController?.tabBar.items?[3].badgeValue {
                let value = Int(badgeValue)! + 1
                badgeValue = String(value)
            } else {
                tabBarController?.tabBar.items?[3].badgeValue = "1"
            }
        case .AppIcon:
            UIApplication.sharedApplication().applicationIconBadgeNumber = 1
        }
    }
}
