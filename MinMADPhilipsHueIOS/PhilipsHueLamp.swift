//
//  PhilipsHueLamp.swift
//  MinMADPhilipsHueIOS
//
//  Created by Ferdinand van Disseldorp on 17/10/2017.
//  Copyright © 2017 Ferdinand van Disseldorp. All rights reserved.
//

import Foundation

class PhilipsHueLamp {
    var id = String()
    var name = String()
    var modelid = String()
    var hue = Int()
    var saturation = Int()
    var brightness = Int()
    
    init(){
        
    }
    
    init(id: String, name: String, modelid: String, hue: Int, saturation: Int, brightness: Int){
        self.id = id
        self.name = name;
        self.modelid = modelid
        self.hue = hue
        self.saturation = saturation
        self.brightness = brightness
    }
    
    func setHue() {
        
    }
    
    func setSaturation(){
        
    }
    
    func setValue(){
        
    }
    
    
}
