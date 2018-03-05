//
//  User.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/2/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import Foundation

class Location{
    
    var id: Int = 0
    var name:String = ""
     var area: String = "Lagos"
    //var imgURL:String = "https://tech-wheel.herokuapp.com/images/techwheel_logo.png"
    var imgURL: String = ""
    var address: String = ""
   
    var latitude: String = ""
    var longitude: String = ""
    var confirmed: String = ""
    var state: String = ""
    var city: String = ""
    
    init(id:Int, name:String, area:String) {
        
        self.id = id
        self.name = name
        self.area = area
        self.imgURL = "https://maps.googleapis.com/maps/api/staticmap?center=\(area),+Nigeria&zoom=13&scale=1&size=100x100&maptype=roadmap&format=png&visual_refresh=true"
    }
    
}
