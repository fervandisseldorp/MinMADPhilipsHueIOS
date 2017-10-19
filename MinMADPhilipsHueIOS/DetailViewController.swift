//
//  DetailViewController.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 19/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selectedLamp : PhilipsHueLamp?
    @IBOutlet weak var backButton: UIButton!
    
    
    @IBOutlet weak var HueSlider: UISlider!
    @IBOutlet weak var SaturationSlider: UISlider!
    @IBOutlet weak var BrightnessSlider: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set max values
        HueSlider.maximumValue = 50000
        SaturationSlider.maximumValue = 255
        BrightnessSlider.maximumValue = 255
        
        // set min values
        HueSlider.minimumValue = 0
        SaturationSlider.minimumValue = 0
        BrightnessSlider.minimumValue = 0

        // set actual values
        HueSlider.value = Float((selectedLamp?.hue)!)
        SaturationSlider.value = Float((selectedLamp?.saturation)!)
        BrightnessSlider.value = Float((selectedLamp?.brightness)!)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Slider value Methods
    //
    // Hue
    @IBAction func HueSlider(_ sender: UISlider) {
        selectedLamp?.hue = Int(sender.value)
        updateLight()
    }
    // Saturation
    @IBAction func SaturationSlider(_ sender: UISlider) {
        selectedLamp?.saturation = Int(sender.value)
        updateLight()
    }
    // Brightness
    @IBAction func BrightnessSlider(_ sender: UISlider) {
        selectedLamp?.brightness = Int(sender.value)
        updateLight()
    }
    
    
    
    
    func updateLight(){
        let connection = RestApiManager.sharedInstance
        
        // Fill in connection stuff
        connection.postPhilipsHue({ (json: NSDictionary?, error: NSError?) in
            if(error == nil){
                print("completed: \(String(describing: json))")
            }else{
                print("Couldn't update light")
            }
            
            }, selectedLamp: self.selectedLamp!)
        
        
        
        
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
