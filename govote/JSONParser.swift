//
//  JSONParser.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/5/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import Foundation

class JSONParser{
    
    static func parse (data : Data) -> [String: AnyObject]?{
        
        let options = JSONSerialization.ReadingOptions();
        
        do{
            
           let json = try JSONSerialization.jsonObject(with: data, options: options)
            as? [String: AnyObject]
            
            return json!
            
        }catch (let parseError){
            
            print(parseError.localizedDescription)
        }
        
        return nil
        
    }
}
