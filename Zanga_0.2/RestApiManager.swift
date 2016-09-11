//
//  RestApiManager.swift
//  UISwiftRestDemo
//
//  Created by Paul O'Neill on 8/18/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void


class RestApiManager {
    static let sharedInstance = RestApiManager()
    
    let randomUserBaseURL = "http://api.randomuser.me/"
    let herokuBaseURL = "http://poneill-event-app.herokuapp.com/"
    
    // MARK: Public methods
    
    func getUserInformation(email: String, completion: (JSON) -> Void){
        let bodyData = ["email":email]
        let route = herokuBaseURL + "user/info"
        makeHTTPPOSTRequest(route, body: bodyData) { (json, error) in
            completion(json as JSON)
        }
    }
    
    func createEvent(title:String, location:String, description:String, pic_loc:String,
                     event_type:String, userId:String, startTime:String, endTime:String,
                     school:String, completion:ServiceResponse) {
        
        let bodyData = ["title":title, "location":location,
                        "description":description, "pic_loc":pic_loc,
                        "event_type":event_type, "creatorUserId":userId,
                        "startTime":startTime, "endTime":endTime, "school":school]
        
        let route = herokuBaseURL + "events/create"
        makeHTTPPOSTRequest(route, body: bodyData) { (json, error) in
            if error != nil {
                completion(nil,error)
            } else {
                completion(json, error)
            }
        }
    }
    
    func getRandomUsers(numOfUsers: String, completion: (JSON) -> Void) {
        let queryDict = ["results":numOfUsers]
        let queryString = queryDict.stringFromHttpParameters()
        
        let route = randomUserBaseURL + "?" + queryString
        makeHTTPGETRequest(route) { (json, error) in
            completion(json as JSON)
        }
    }
    
    
    // MARK: Private methods
    
    private func makeHTTPGETRequest(path: String, completion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                completion(json, error)
            } else {
                completion(nil, error)
            }
        })
        task.resume()
    }
    
    private func makeHTTPPOSTRequest(path: String, body: [String:AnyObject], completion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        request.HTTPMethod = "POST"
        
        do {
            let jsonBody = try NSJSONSerialization.dataWithJSONObject(body, options: .PrettyPrinted)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.HTTPBody = jsonBody
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if let jsonData = data {
                    let json:JSON = JSON(data: jsonData)
                    completion(json, nil)
                } else {
                    completion(nil, error)
                }
            })
            task.resume()
        } catch {
            print("NSJSONSerialization failed...")
            completion(nil, nil)
        }
    }
    
    
}