//
//  PhilipsViewController.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 17/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class PhilipsViewController: UITableViewController {
    @IBOutlet weak var testbutton: UIButton!
    var lampArray = [PhilipsHueLamp]()
    
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
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lampArray.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lampCell", for: indexPath) as! LampTableViewCell
        print(lampArray)
        
        let row = indexPath.row
        cell.LabelLampId.text = lampArray[row].name + " " + lampArray[row].id
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in the segue")
        if(segue.identifier=="toLampDetails"){
            if let destination = segue.destination as? DetailViewController {
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let selectedPhilipsHueLamp = lampArray[indexPath.row]
                    destination.selectedLamp = selectedPhilipsHueLamp
                }
            }
        }
        if(segue.identifier == "backButton"){
            print("back button pressed")
        }
    }
    
    
    
    // Get all the available PhilipsHueLamps
    //
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
                        let currentState = lampState.value(forKey: "on") as! Bool
                        let brightness = lampState.value(forKey: "bri") as! Int
                        let hue = lampState.value(forKey: "hue") as! Int
                        let saturation = lampState.value(forKey: "sat") as! Int
                    let name = lamp?.value(forKey: "name") as! String
                    let modelid = lamp?.value(forKey: "modelid") as! String
                    
                    print("lamp with id: " + lampId + " has values:   \(brightness) + \(hue) + \(saturation)" )
                    
                    let philipsHueLamp = PhilipsHueLamp(id: lampId, name: name, modelid: modelid, hue: hue, saturation: saturation, brightness: brightness, currentState: currentState)
                    self.lampArray.append(philipsHueLamp)
                    self.tableView.reloadData()
                    
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
