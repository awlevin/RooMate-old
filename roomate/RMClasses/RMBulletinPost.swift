//
//  RMBulletinPost.swift
//  roomate
//
//  Created by Ritvik Upadhyaya on 19/10/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

public struct RMBulletinPost {
    var objectId: Int
    var dateCreatedAt: String
    var dateupdatedAt: String
    var title: String!
    var description: String!
    var pinNote: Bool!
    var photos: [String]!
    var thumbnail: String!
    var removalDate: String!
    var comments: [String: String]
    
    
    
    
    
    func getImageForPost(completion: (String?) -> ()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMPostPics"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(self.objectId)", forHTTPHeaderField: "postid")
        
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
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(nil)
                    })
                    break
                default:
                    completion(nil)
                    break
                }
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    return
                }
                if json.count < 1 {
                    return
                }
                let jsonObject = json[0] as! [String : AnyObject]
                if jsonObject["postid"] != nil {
                    let objId = jsonObject["postid"] as! Int
                    if objId != self.objectId {
                        return
                    }
                    let imageData = jsonObject["photourl"] as! String
                    if imageData.characters.count != 0 {
                        if imageData.rangeOfString("/9j/") != nil {
                            completion(imageData)
                            return
                        } else {
                            completion(nil)
                            return
                        }
                    }else {
                        completion(nil)
                        return
                    }
                } else {
                    completion(nil)
                    return
                }
            }
        }
        task.resume()
    }
 
    
    static func createNewBulletinPost(bbPost: RMBulletinPost, user: RMUser, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMPost"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        let bbDictionary = RMBulletinPost.createBBDictionary(bbPost, user: user)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(bbDictionary, options: [.PrettyPrinted])
        } catch let error as NSError {
            print(error)
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 8.0
        configuration.timeoutIntervalForResource = 8.0
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
    
    static func getBulletinPosts(offset: Int, lastid: Int, groupId: Int, completionHandler: (bbPosts: [RMBulletinPost])->()) {
        
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/selectRMPosts"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("\(groupId)", forHTTPHeaderField: "groupid")
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
                    var returnedPosts = [RMBulletinPost]()
                    for jsonItem in json {
                        guard let jsonItemDict = jsonItem as? [String: AnyObject]
                            else { continue }
                        let currPost = RMBulletinPost(objectId: jsonItemDict["postid"] as! Int, dateCreatedAt: jsonItemDict["datecreatedat"] as! String, dateupdatedAt: jsonItemDict["dateupdatedat"] as! String, title: jsonItemDict["title"] as! String, description: jsonItemDict["description"] as! String, pinNote: jsonItemDict["pinnote"] as! Bool, photos: [], thumbnail: "", removalDate: "", comments: [:])
                        returnedPosts.append(currPost)
                    }
                    completionHandler(bbPosts: returnedPosts)
                    return
                }
            }
        }
        task.resume()
    }
    
    
    static func createBBDictionary(bbObject: RMBulletinPost, user: RMUser) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        returnDict["userid"] = user.userObjectID
        returnDict["groupid"] = user.groupID
        returnDict["title"] = bbObject.title
        returnDict["description"] = bbObject.description
        returnDict["pinnote"] = bbObject.pinNote.boolValue
        returnDict["photourl"] = bbObject.photos[0]
        //returnDict["thumbnail"] = bbObject.thumbnail
        returnDict["removaldate"] = "11/14/2016" // TODO: Fix this
        //returnDict["comments"] = bbObject.comments
        print("##################")
        print(returnDict["title"])
        return returnDict
    }
}
