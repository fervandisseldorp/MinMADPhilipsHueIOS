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
    }
    
    func getPhilipsHueLamps(_ onCompletion: @escaping (NSDictionary?, NSError?) -> Void ) {
        // format url van String
        let url = URL(string: baseUrl!)!
        // Reuest is a struct
        var request = URLRequest(url: url)
        // Get
        request.httpMethod = "GET"
        // Extras
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            print("Task done")
            
            if(error != nil) {
                print(error!.localizedDescription)
                onCompletion(nil, error! as NSError)
            }
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
    
    
    func postPhilipsHue(_ onCompletion: @escaping (NSDictionary?, NSError?) -> Void, selectedLamp: PhilipsHueLamp){
        let baseUrl = "http://192.168.1.179/api/lXPypsuuj4ujhAlXdZP2URMJpVZwqUS-HAMrojC0/lights/"
        let extendedUrl = "\(selectedLamp.id)/state/"
        let completeUrl = URL(string: (baseUrl + extendedUrl))
        
        var request = URLRequest(url: completeUrl!)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["bri": selectedLamp.brightness,
                                   "hue": selectedLamp.hue,
                                   "sat": selectedLamp.saturation,
                                   "on": selectedLamp.currentState]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpMethod = "PUT"
        request.httpBody = jsonData;
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            print("Task done")
            
            if(error != nil) {
                print(error!.localizedDescription)
                onCompletion(nil, error! as NSError)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                
                onCompletion(json, nil)
            } catch {
                onCompletion(nil, error as NSError)
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

