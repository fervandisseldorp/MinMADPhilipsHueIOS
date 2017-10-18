//
//  PhilipsViewController.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 17/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class PhilipsViewController: UIViewController {
    var amountLamps: Int = 10
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view did load")
        connectToPhilipsHue()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func connectToPhilipsHue(){
        let connection = RestApiManager.sharedInstance
        connection.getPhilipsHueLamps( {(json: NSDictionary?, error: NSError?) -> Void in
            
            if(error == nil ){
                print("On Completion: \(String(describing: json))")
                
                for i in 1...10 {
                    print("id = \(i)")
                    
                    
                    
                }
                
                let current_value = json?.object(forKey: "current_value");
                
                
                // ! Important, alleen op de main thread UI update!
                DispatchQueue.main.async(execute: {
                    
                })
                
                //
                
            } else {
                print(error!.localizedDescription)
            }
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
