//
//  RestApiManager.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 17/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class RestApiManager: NSObject {
    
    // Make it singleton
    static let sharedInstance = RestApiManager()
    
    var baseUrl : String?
    var apiKey: String?
    
    override init() {
        baseUrl = "http://192.168.1.179/api/lXPypsuuj4ujhAlXdZP2URMJpVZwqUS-HAMrojC0/lights"
        // apiKey = "P_btPeh4FcS-eBfr4NheLke2QvSSAKxmZ0hRQ2taTGlxYz0g"
    }
    
    func getPhilipsHueLamps(_ onCompletion: @escaping (NSDictionary?, NSError?) -> Void ) {
        
        // format url van String
        let url = URL(string: baseUrl!)!
        
        // Reuest is a struct
        var request = URLRequest(url: url)
        
        // Get
        request.httpMethod = "GET"
        
        // Extras
        // request.addValue(apiKey!, forHTTPHeaderField: "X-PachubeApiKey")
        
        let session = URLSession.shared
        
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            print("Task done")
            
            if(error != nil) {
                print(error!.localizedDescription)
                onCompletion(nil, error! as NSError)
            }
            
            // Do try .. get json results
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                // succes
                onCompletion(json,nil)
            } catch {
                // failure
                onCompletion(nil,error as NSError)
            }
        })
        
        task.resume()
    }
    
    
    
//    func test(){
//        let url = URL(string: "http://192.168.1.179/api/lXPypsuuj4ujhAlXdZP2URMJpVZwqUS-HAMrojC0/lights")
//        let task = URLSession.shared.dataTask(with: url!) { data, response, error) in
//            if error != nil {
//                print("Error")
//            }
//            else{
//                
//            }
//    }
    
    
    
    
}

