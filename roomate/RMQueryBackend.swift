//
//  RMQueryBackend.swift
//  roomate
//
//  Created by Aaron Levin on 12/5/16.
//  Copyright © 2016 RooMate. All rights reserved.
//

import Foundation


struct RMQueryBackend {

    
    /**
        @param url: String ––– the full URL of the request
        @param parameters: [String : String] ––– [headerField : value]
        @return jsonResponse: NSArray? ––– returns a JSON array of 1 or more JSON objects. Otherwise returns nil (If success == false, jsonResponse will be nil).
        The completion handler for this method returns success if and only if the status code of the request was 200 and a JSON array with 1 or more items is returned.
     */
    static func get(url: String, parameters: [String : String], completion: (success: Bool, jsonResponse: NSArray?) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Add parameters to the request
        for (key, value) in parameters {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Set configuration and create session
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        
        print("****************REQUEST**************")
        print("body: \(request.HTTPBody)")
        print("headerFieldGroupIDValue: \(request.valueForHTTPHeaderField("groupid"))")
        print("all headerFields: \(request.allHTTPHeaderFields)")
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            
            var httpResponse: NSHTTPURLResponse?
            var strData: NSString?
            
            // Check for non-nil response
            if (response as? NSHTTPURLResponse != nil) {
                
                httpResponse = response as! NSHTTPURLResponse
                
                print("Response: \(response)")
                strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
            } else {
                print("Response was nil.")
                completion(success: false, jsonResponse: nil)
            }
            
            // Check if there's error
            if(error != nil) {
                print("Encountered an error...\n\(error)")
                completion(success: false, jsonResponse: nil)
            }
            
            // Retrieve JSON
            var json: NSArray?
            do {
                if (data != nil) {
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("jsonString: \(jsonStr)")
                    
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSArray
                } else {
                    print("JSON Data was nil.")
                    json = nil
                    completion(success: false, jsonResponse: nil)
                }
            } catch let error as NSError {
                print("Encountered an error...\n\(error)")
                completion(success: false, jsonResponse: nil)
            }
            
            
            
            // Successful if there's at least 1 object in the JSON array AND statusCode == 200
            if json != nil {
                let statusCode = httpResponse!.statusCode
                
                if statusCode == 200 {
                    completion(success: true, jsonResponse: json!)
                } else {
                    completion(success: false, jsonResponse: nil)
                    print("Error: Status Code: \(statusCode)")
                }
            }
            else {
                // JSON object was nil.
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: \(jsonStr)")
                completion(success: false, jsonResponse: nil)
            }
        }
        task.resume()
    }


    /*
    /**
     @param urlPostfix: String of the form "selectRMGroceries" *** Note that the foremost '/' is omitted.
     @param valueForHeaderFieldDict: [AnyObject: String] -- String is the HTTPHeaderField value, AnyObject is the value to send in the request.
     @return a serialized JSON object.
    */
    func getJSONFromBackend(url: String, valueForHeaderFieldDict: [String : AnyObject], completionHandler: (reqResponse: RequestResponse)->()) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()

        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        for (httpHeader, value) in valueForHeaderFieldDict {
            request.addValue("\(value)", forHTTPHeaderField: "\(httpHeader)")
        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
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
    } */
    
    
    // returns a SINGLE JSON dictionary!
    static func post(url: String, params: [String : AnyObject], postCompleted : (succeeded: Bool, jsonResponse: [String : AnyObject]?) -> ()) {
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
        
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            var strData: NSString?
            print("Response: \(response)")
            if (data != nil) {
                strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)")
            }
            // var err: NSError?
            
            
            if (strData! == "Post was successful") {
                postCompleted(succeeded: true, jsonResponse: nil)
            }
            
            var json: NSDictionary?
            do {
                if (data != nil) {
                    json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary
                } else {
                    json = nil
                }
            } catch let error as NSError {
                err = error
                print(error)
            }
            
            // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
            if(err != nil) {
                print(err!.localizedDescription)
                let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print("Error could not parse JSON: '\(jsonStr)'")
                postCompleted(succeeded: false, jsonResponse: nil )
            }
            else {
                // The JSONObjectWithData constructor didn't return an error. But, we should still
                // check and make sure that json has a value using optional binding.
                if let parseJSON = json as! [String : AnyObject]? {
                    if let httpResponse = response as! NSHTTPURLResponse? {
                        let statusCode = httpResponse.statusCode
                        
                        if statusCode == 200 {
                            postCompleted(succeeded: true, jsonResponse: parseJSON)
                            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                            
                        } else {
                            postCompleted(succeeded: false, jsonResponse: nil)
                            print(statusCode)
                        }
                    }
                    
                    
                }
                else {
                    // JSON object was nil.
                    
                    let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print("Error could not parse JSON: \(jsonStr)")
                    
                    postCompleted(succeeded: false, jsonResponse: nil)
                }
            }
        })
        task.resume()
    }
}
