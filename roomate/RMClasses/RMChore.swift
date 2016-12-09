//
//  RMChore.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMChore {
    var choreID: Int // Also known as unique identifier
    var groupID: Int
    var userID: Int // Who did the chore
    var title: String
    var description: String // AKA additional notes
    var dateCreated: String
    
    // START TEST METHODS:
    static func returnTestChore() -> RMChore {
        let testUser = RMUser.returnTestUser()
        
        return RMChore(choreID: 0, groupID: testUser.groupID!, userID: testUser.userObjectID, title: "XCTest Chore Completion Title!!", description: "XCTest Chore Completion2 Description", dateCreated: "00/00/00")
    }
    // END TEST METHODS
    
    static func createNewChore(chore: RMChore, completionHandler: (completed: Bool, newChoreID: Int?)->()) {
        let choreDictionary = RMChore.createChoreDictionary(chore)
        
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/createRMChore", params: choreDictionary) { (success, jsonResponse) in
            
            if success {
                let choreID = jsonResponse?["choreid"] as! Int
                completionHandler(completed: true, newChoreID: choreID)
            } else {
                completionHandler(completed: false, newChoreID: nil)
            }
        }
    }
    
    /*
    static func createNewChore(chore: RMChore, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMChore"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        let choreDictionary = RMChore.createChoreDictionary(chore)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(choreDictionary, options: [.PrettyPrinted])
            print("**********************")
            print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                print("status code: \(statusCode)")
                switch statusCode {
                case 400:
                    completionHandler(completed: false)
                    break
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                completionHandler(completed: true)
            }
        }
        task.resume()
    }*/
    
    static func deleteChore(choreID: Int, completionHandler: (completed: Bool)->()) {
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/deleteRMChores", parameters: ["choreid":"\(choreID)"]) { (success, jsonResponse) in
            (success) ? completionHandler(completed: true) : completionHandler(completed: false)
        }
    }
    
    /*static func deleteChore(choreid: Int, completionHandler: (completed: Bool) -> () ) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/deleteRMChores"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(choreid)", forHTTPHeaderField: "choreid")
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil){
                switch statusCode {
                case 400:
                    completionHandler(completed: false)
                    break
                case 404:
                    completionHandler(completed: false)
                    break
                case 503:
                    completionHandler(completed: false)
                    break
                case 200:
                    completionHandler(completed: true) // success
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                completionHandler(completed: true)
            }
        }
        task.resume()
    }*/
    
    static func getChores(offset: Int, lastid: Int, groupId: Int, completionHandler: (chores: [RMChore])->()) {
        
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMChores"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(groupId)", forHTTPHeaderField: "groupid")
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }

            if(error != nil || data == nil || statusCode != 200){
                print("status code: \(statusCode)")
                switch statusCode {
                case 400:
                    completionHandler(chores: [])
                    break
                default:
                    completionHandler(chores: [])
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completionHandler(chores: [])
                    return
                }
                
                if json.count == 0 {
                    completionHandler(chores: [] )
                    return
                }
                else {
                    var returnedPosts = [RMChore]()
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        
                        let currPost = RMChore(choreID: jsonItemDict["choreid"] as! Int, groupID: jsonItemDict["groupid"] as! Int, userID: jsonItemDict["userid"] as! Int, title: jsonItemDict["choretitle"] as! String, description: jsonItemDict["description"] as! String,  dateCreated: jsonItemDict["datecreatedat"] as! String)
                        returnedPosts.append(currPost)
                    }
                    completionHandler(chores: returnedPosts)
                    return
                }
            }
        }
        task.resume()
    }
    
    static func updateChoreBefore(choreid: Int, beforePhoto: String, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/updateRMChoreBefore"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let choreDictionary = ["choreid" : choreid,
                               "beforePhotoURL" : beforePhoto]
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(choreDictionary, options: [.PrettyPrinted])
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                switch statusCode {
                case 400:
                    completionHandler(completed: false)
                    break
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                completionHandler(completed: true)
            }
        }
        task.resume()
    }

    static func updateChoreAfter(choreid: Int, afterPhoto: String, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/updateRMChoreAfter"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let choreDictionary = ["choreid" : choreid,
                               "afterPhotoURL" : afterPhoto]
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(choreDictionary, options: [.PrettyPrinted])
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                switch statusCode {
                case 400:
                    completionHandler(completed: false)
                    break
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                completionHandler(completed: true)
            }
        }
        task.resume()
    }
    
    func createRMChoreCompletion(user: RMUser, completionHandler: (completed: Bool) ->()) {
        let choreCompletionDictionary = RMChoreCompletion.createChoreCompletionDictionary(self, user: user)
        
        RMQueryBackend.post("https://damp-plateau-63440.herokuapp.com/createRMChoreCompletion", params: choreCompletionDictionary) { (success, jsonResponse) in
            (success) ? completionHandler(completed: true) : completionHandler(completed: false)
        }
    }
    
    /*func createRMChoreCompletion(user: RMUser, completionHandler: (completed: Bool) -> ()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMChoreCompletion"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        let choreDictionary = RMChoreCompletion.createChoreCompletionDictionary(self, user: user)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(choreDictionary, options: [.PrettyPrinted])
            print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                print("status code: \(statusCode)")
                switch statusCode {
                case 400:
                    completionHandler(completed: false)
                    break
                default:
                    completionHandler(completed: false)
                    break
                }
                return
            } else {
                let json = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                completionHandler(completed: true)
                print("success")
            }
        }
        task.resume()
    }*/
    
    // completed == true upon successful query
    // choreCompletions will be nil if the returned list was empty, completed will still be true if the query was successful
    // completed == false if the query was unsuccessful
    func getRMChoreCompletions(completionHandler: (completed: Bool, choreCompletions: [RMChoreCompletion]?)->()) {
        RMQueryBackend.get("https://damp-plateau-63440.herokuapp.com/selectRMChoreCompletions", parameters: ["choreid":"\(self.choreID)"]) { (success, jsonResponse) in
            
            var choreCompletions: [RMChoreCompletion]? = nil
            
            if ( success && (jsonResponse?.count > 0) ) {
                
                for choreCompletion in jsonResponse! {
                    
                    let currChoreCompletion = RMChoreCompletion(choreCompletionID: choreCompletion["chorecompletionid"] as! Int, choreID: choreCompletion["choreid"] as! Int, personCompletedUserID: choreCompletion["userid"] as! Int, groupID: choreCompletion["groupid"] as! Int, title: choreCompletion["title"] as! String, additionalComments: choreCompletion["description"] as! String, beforePhotoURL: "", afterPhotoURL: "", dateCompleted: choreCompletion["datecompleted"] as! String)
                    
                    choreCompletions!.append(currChoreCompletion)
                }
                completionHandler(completed: true, choreCompletions: choreCompletions)
            
            } else if success {
                completionHandler(completed: true, choreCompletions: nil)
            } else{
                completionHandler(completed: false, choreCompletions: nil)
            }
        }
    }
    
    /*func getRMChoreCompletions(completionHandler: (choreCompletions: [RMChoreCompletion])->() ) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMChoreCompletions"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(self.choreID)", forHTTPHeaderField: "choreid")
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                switch statusCode {
                case 400:
                    completionHandler(choreCompletions: [])
                    break
                default:
                    completionHandler(choreCompletions: [])
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completionHandler(choreCompletions: [])
                    return
                }
                
                if json.count == 0 {
                    completionHandler(choreCompletions: [] )
                    return
                }
                else {
                    var returnedChoreCompletions = [RMChoreCompletion]()
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }

                        let currChoreCompletion = RMChoreCompletion(choreCompletionID: jsonItemDict["chorecompletionid"] as! Int, choreID: jsonItemDict["choreid"] as! Int, personCompletedUserID: jsonItemDict["userid"] as! Int, groupID: jsonItemDict["groupid"] as! Int, title: jsonItemDict["title"] as! String, additionalComments: jsonItemDict["description"] as! String, beforePhotoURL: "", afterPhotoURL: "", dateCompleted: jsonItemDict["datecompleted"] as! String)
                        
                        returnedChoreCompletions.append(currChoreCompletion)
                    }
                    completionHandler(choreCompletions: returnedChoreCompletions)
                    return
                }
            }
        }
        task.resume()
    }*/
    
    

    
    static func createChoreDictionary(choreObject: RMChore) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        returnDict["groupid"] = choreObject.groupID
        returnDict["userid"] = choreObject.userID
        returnDict["choretitle"] = choreObject.title
        returnDict["description"] = choreObject.description
        return returnDict
    }
    
}
