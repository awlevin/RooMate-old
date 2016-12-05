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
    }
    
    static func deleteChore(choreid: Int, completionHandler: (completed: Bool) -> () ) {
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
    }
    

    static func getChores(offset: Int, lastid: Int, groupId: Int, completionHandler: (chores: [RMChore])->()) {
        
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMChores"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "groupid")
        
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
    
    func createRMChoreCompletion(user: RMUser, completionHandler: (completed: Bool) -> ()) {
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
    }
    
    func getRMChoreCompletions(completionHandler: (choreCompletions: [RMChoreCompletion])->() ) {
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
    }
    
    

    
    static func createChoreDictionary(choreObject: RMChore) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        returnDict["groupid"] = choreObject.groupID
        returnDict["userid"] = choreObject.userID
        returnDict["choretitle"] = choreObject.title
        returnDict["description"] = choreObject.description
        return returnDict
    }
    
}
