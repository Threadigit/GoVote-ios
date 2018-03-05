//
//  LocationdataProcessor.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/5/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import Foundation

class LocationdataProcessor{
    
    static func mapJsonToLocation (object: [String:AnyObject], locKeys: String) -> [Location]{
        
        var mapedLocs: [Location] = []
        
        guard let locations = object[locKeys] as? [[String: AnyObject]] else {
            return mapedLocs}
        
        for location in locations{
            
            guard let id = location["id"] as? Int,
                let area = location["area"] as? String,
                //let latitude = location["latitude"] as? String,
                //let longitude = location["longitude"] as? String,
               let name = location["name"] as? String
            else{ continue }
            
            print(name)
            let locationClass = Location(id: id,name:name,area:"Lagos")
            locationClass.area = area
            //locationClass.latitude = latitude
            //locationClass.longitude = longitude
            mapedLocs.append(locationClass)
            
        }
        print(mapedLocs.count)
        
        return mapedLocs
    }
    
    static func write(locations: [Location]){
        
    }
    
}
