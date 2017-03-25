//
//  Weather.swift
//  Contato
//
//  Created by Nando on 24/03/17.
//  Copyright © 2017 Nando. All rights reserved.
//

import UIKit
import ObjectMapper

class Weather: Mappable {

    var icon:String!
    var min: Double!
    var max: Double!
    var condition: String!
    
    required init?(map: Map) {
        
    }
        
    // Mappable
    func mapping(map: Map) {
        
        min <- map["main.temp_min"]
        max <- map["main.temp_max"]
        condition <- map["weather.0.main"]
        icon <- map["weather.0.icon"]
        
    }
}
