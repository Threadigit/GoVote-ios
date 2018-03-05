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
    var imgURL:String = "https://tech-wheel.herokuapp.com/images/techwheel_logo.png"
    var address: String = ""
    var area: String = "Lagos"
    var latitude: String = ""
    var longitude: String = ""
    var confirmed: String = ""
    var state: String = ""
    var city: String = ""
    
    init(id:Int, name:String, area:String) {
        
        self.id = id
        self.name = name
        self.area = area
    }
    
}
