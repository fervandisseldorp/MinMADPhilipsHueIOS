//
//  PhilipsViewController.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 17/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class PhilipsViewController: UIViewController {
    @IBOutlet weak var testbutton: UIButton!
    
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
            
            let lampIds = json?.allKeys as! [String]
            
            if(error == nil ){
                print("On Completion: \(String(describing: json))")
                
                // loop through found lamps
                for lampId in lampIds {
                    
                    
                    let lamp = json?.value(forKey: lampId) as? NSObject
                    let lampState = lamp?.value(forKey: "state") as! NSObject
                        let brightness = lampState.value(forKey: "bri") as! Int
                        let hue = lampState.value(forKey: "hue") as! Int
                        let saturation = lampState.value(forKey: "sat") as! Int
                    
                    print("lamp with id: " + lampId + "has values:   \(brightness) + \(hue) + \(saturation)" )
                    
                }
            
                // ! Important, alleen op de main thread UI update!
                DispatchQueue.main.async(execute: {
                    
                })
                
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
