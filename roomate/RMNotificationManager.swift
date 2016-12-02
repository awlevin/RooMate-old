//
//  RMNotificationManager.swift
//  roomate
//
//  Created by Aaron Levin on 10/31/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
import UIKit


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



struct RMNotificationManger {
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
        case .Grocery:
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
    
    public func sentPushTo(userId: String, message: String, pushType: RMPushTypes) {
        switch pushType {
        case .Message:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "Name of user"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            return
        case .BulletinBoard:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "Meet Request!"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            
            return
        case .Chore:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "User Request!"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            return
        case .FinanceBill:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "Name of user"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            return
        case .GroceryShopping:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "Name of user"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            return
        case.CommunalGrocery:
//            OneSignal.postNotification(["contents": ["en": message],
//                "headings": ["en" : "Name of user"],
//                "include_player_ids": [userId],
//                "ios_badgeType": "Increase",
//                "ios_badgeCount": 1])
            return
        }
    }
    
    /**
     
     Initialize and configure push notifications, should be called in AppDelegate. Push notifications will be handled through here
     
     - Parameter launchOptions: UIApplication launch options found in the AppDelegate
     
     */
    
//    func configure(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
//        OneSignal.initWithLaunchOptions(launchOptions, appId: "4bfe00f1-e849-4daf-a559-924b9dcc74de", handleNotificationReceived: { (notification) in
//            
//            print("Received Notification - \(notification?.payload.notificationID)")
//            
//            let payload = notification?.payload
//            
//            //if payload?.title ==
//            
//            
//            }, handleNotificationAction: { (result) in
//                
//                // This block gets called when the user reacts to a notification received
//                
//                // **TODO**  2. Open proper viewControllers accordingly
//                let payload = result?.notification.payload
//                
//                if payload?.title == "Name of user" {
//                    self.didRecievePush(pushType: .Message)
//                } else if payload?.title == "Meet Request!" {
//                    self.didRecievePush(pushType: .MeetRequest)
//                } else if payload?.title == "User Request!" {
//                    self.didRecievePush(pushType: .UserRequest)
//                } else { // Survey notification!
//                    // **TODO**  1. Display survey
//                }
//                
//                
//            }, settings: [kOSSettingsKeyAutoPrompt : true, kOSSettingsKeyInAppAlerts : false])
//        
//    }
    
    /**
     
     Prompt user to register for push notifications. Does not to be used if configure is called.
     
     */
    
    func registerForPushNotifications() {
       // OneSignal.registerForPushNotifications()
    }
}

// MARK: - Private Functions

//private extension DSNotificationManager {
//    func sendNotificationAfter(value: Int, component: Calendar.Component) -> String {
//        let today = Date()
//        let futureDate = Calendar.current.date(byAdding: .minute, value: 1, to: today)
//        return futureDate!.toString()
//    }
//    
//    // **TODO** 4. After storyboard flow is complete, figure out where tabController is and increment notification
//    func didRecievePush(pushType: DSPushTypes) {
//        switch pushType {
//        case .Message:
//            //            if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            //                let tabController = topController.childViewControllers[1] as? UITabBarController
//            //                incrementBadgeOn(tab: .Message, tabBarController: tabController)
//            //            }
//            // Handle message
//            return
//        case .MeetRequest:
//            //            if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            //                let tabController = topController.childViewControllers[0] as? UITabBarController
//            //                incrementBadgeOn(tab: .Request, tabBarController: tabController)
//            //            }
//            // Handle meet request
//            return
//        case .UserRequest:
//            //            if let topController = UIApplication.shared.keyWindow?.rootViewController {
//            //                let tabController = topController.childViewControllers[1] as? UITabBarController
//            //                incrementBadgeOn(tab: .Request, tabBarController: tabController)
//            //            }
//            // Handle User request
//            return
//        }
//    }
//    
//    /**
//     
//     Add badge to a tab in the TabBarController or add a badge to the app icon
//     */
//    
//    func incrementBadgeOn(tab: DSTabTypes, tabBarController: UITabBarController?) {
//        switch tab {
//        case .Discover:
//            if var badgeValue = tabBarController?.tabBar.items?[0].badgeValue {
//                let value = Int(badgeValue)! + 1
//                badgeValue = String(value)
//            } else {
//                tabBarController?.tabBar.items?[0].badgeValue = "1"
//            }
//            return
//        case .Deck:
//            if var badgeValue = tabBarController?.tabBar.items?[1].badgeValue {
//                let value = Int(badgeValue)! + 1
//                badgeValue = String(value)
//            } else {
//                tabBarController?.tabBar.items?[1].badgeValue = "1"
//            }
//        case .Request:
//            if var badgeValue = tabBarController?.tabBar.items?[2].badgeValue {
//                let value = Int(badgeValue)! + 1
//                badgeValue = String(value)
//            } else {
//                tabBarController?.tabBar.items?[2].badgeValue = "1"
//            }
//            return
//        case .Message:
//            if var badgeValue = tabBarController?.tabBar.items?[3].badgeValue {
//                let value = Int(badgeValue)! + 1
//                badgeValue = String(value)
//            } else {
//                tabBarController?.tabBar.items?[3].badgeValue = "1"
//            }
//        case .AppIcon:
//            UIApplication.shared.applicationIconBadgeNumber = 1
//        }
//    }
//}
