//
//  RMChore.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 26/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation
public struct RMChore {
    var objectId: Int // Also known as unique identifier
    var groupId: Int
    var dateCompleted: String?
    var userId: Int // Who did the chore
    var description: String // AKA additional notes
    var title: String
    var beforePhoto: String // Base64
    var afterPhoto: String
    var completionHistory: [String: String] // <username : Time of completion>
    var commentHistory: [String: String] // <username: comment>

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
            }
        }
        task.resume()
    }

    static func getNewChores(offset: Int, lastid: Int, groupId: Int, completionHandler: (bbPosts: [RMChore])->()) {
        
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMChores"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("1", forHTTPHeaderField: "groupid")
        request.addValue("\(lastid)", forHTTPHeaderField: "lastid")
        
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
                    completionHandler(bbPosts: [])
                    break
                default:
                    completionHandler(bbPosts: [])
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completionHandler(bbPosts: [])
                    return
                }
                
                if json.count == 0 {
                    completionHandler(bbPosts: [] )
                    return
                }
                else {
                    var returnedPosts = [RMChore]()
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        //let currPost = RMBulletinPost(objectId: jsonItemDict["postid"] as! Int, dateCreatedAt: jsonItemDict["datecreatedat"] as! String, dateupdatedAt: jsonItemDict["dateupdatedat"] as! String, title: jsonItemDict["title"] as! String, description: jsonItemDict["description"] as! String, pinNote: jsonItemDict["pinnote"] as! Bool, photos: [], thumbnail: "", removalDate: "", comments: [:])
                        let currPost = RMChore(objectId: jsonItemDict["choreid"] as! Int, groupId: jsonItemDict["groupid"] as! Int, dateCompleted: jsonItemDict["datecompleted"] as? String, userId:jsonItemDict["ownerid"] as! Int, description: jsonItemDict["description"] as! String, title: jsonItemDict["title"] as! String, beforePhoto: "", afterPhoto:"", completionHistory: ["":""], commentHistory: ["":""])
                        returnedPosts.append(currPost)
                    }
                    completionHandler(bbPosts: returnedPosts)
                    return
                }
            }
        }
        task.resume()
    }
    

    
    static func createChoreDictionary(choreObject: RMChore) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        returnDict["title"] = choreObject.title
        returnDict["description"] = choreObject.description
        returnDict["userid"] = choreObject.userId
        returnDict["groupid"] = choreObject.groupId
        /*returnDict["photourl"] = bbObject.photos
        //returnDict["thumbnail"] = bbObject.thumbnail
        returnDict["removaldate"] = "11/14/2016"
        //returnDict["comments"] = bbObject.comments
        print("##################")
        print(returnDict["title"])*/
        return returnDict
    }
    
}
