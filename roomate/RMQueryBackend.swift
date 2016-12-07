//
//  RMQueryBackend.swift
//  roomate
//
//  Created by Aaron Levin on 12/5/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation

struct RequestResponse {
    let success: Bool
    let statusCode: Int
    let JSONresult: NSArray
}

struct RMQueryBackend {

    /**
     @param urlPostfix: String of the form "selectRMGroceries" *** Note that the foremost '/' is omitted.
     @param valueForHeaderFieldDict: [AnyObject: String] -- String is the HTTPHeaderField value, AnyObject is the value to send in the request.
     @return a serialized JSON object.
    */
    func getJSONFromBackend(urlPostfix: String, valueForHeaderFieldDict: [String : AnyObject], completionHandler: (reqResponse: RequestResponse)->()) {
        let apiCallString = "https://damp-plateau-63440.herokuapp.com/\(urlPostfix)"
        let httpURL = NSURL(string: apiCallString)
        let request = NSMutableURLRequest(URL: httpURL!)

        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (httpHeader, value) in valueForHeaderFieldDict {
            request.addValue("\(value)", forHTTPHeaderField: "\(httpHeader)")
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            var statusCode = 0
            if let httpResponse = response as? NSHTTPURLResponse {
                statusCode = httpResponse.statusCode
            }
            
            if(error != nil || data == nil || statusCode != 200){
                completionHandler(reqResponse: RequestResponse(success: false, statusCode: statusCode, JSONresult: []))
                return
            } else {
                var json: NSArray
                do {
                    try json = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSArray
                } catch {
                    completionHandler(reqResponse: RequestResponse(success: false, statusCode: statusCode, JSONresult: []))
                    return
                }
                
                completionHandler(reqResponse: RequestResponse(success: true, statusCode: statusCode, JSONresult: json))
                
                // TODO: Revert to "requestDict" for generically interpreting the JSON data. Google "how to handle lots of backend requests in model." Also can use a switch with "interpretType" enum to know to unwrap objects as! Int or String etc. 
                
            }
        }
        task.resume()
    }
    
    static func post(params : Dictionary<String, String>, url : String, postCompleted : (succeeded: Bool, msg: String) -> ()) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var err: NSError?
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: [.PrettyPrinted])
            
        } catch let error as NSError {
            err = error
            print(error)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("Body: \(strData)")
            // var err: NSError?
            
            
            var json: NSDictionary?
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
            } catch let error as NSError {
                print(error)
            }
            
            
            // var msg = "No message"
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, msg: "Error")
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json {
                    // Okay, the parsedJSON is here, let's get the value for 'success' out of it
                    if let success = parseJSON["success"] as? Bool {
                        print("Succes: \(success)")
                        postCompleted(succeeded: success, msg: "Logged in.")
                    }
                    return
                }
                else {
                    // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    postCompleted(succeeded: false, msg: "Error")
                }
            }
        })
        task.resume()
    }
}
