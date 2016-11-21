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
    
    
    static func createNewBulletinPost(bbPost: RMBulletinPost, completionHandler: (completed: Bool)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/createRMPost"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)
        
        let bbDictionary = RMBulletinPost.createBBDictionary(bbPost)
        
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do
        {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(bbDictionary, options: [.PrettyPrinted])
            print("**********************")
            print(NSString(data: request.HTTPBody!, encoding:NSUTF8StringEncoding)!)
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
        request.addValue("1", forHTTPHeaderField: "groupid")
        request.addValue("\(lastid)", forHTTPHeaderField: "lastid")
        
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
    
    static func createBBDictionary(bbObject: RMBulletinPost) -> [String : AnyObject] {
        var returnDict = [String : AnyObject]()
        returnDict["title"] = bbObject.title
        returnDict["description"] = bbObject.description
        returnDict["pinnote"] = bbObject.pinNote.boolValue
        returnDict["photourl"] = bbObject.photos
        //returnDict["thumbnail"] = bbObject.thumbnail
        returnDict["removaldate"] = "11/14/2016"
        //returnDict["comments"] = bbObject.comments
        print("##################")
        print(returnDict["title"])
        return returnDict
    }
}
