//
//  HttpHandler.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/5/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import Foundation

class HttpHandler{
    
    static func getJSON(urlString:String, completionhandler: @escaping (Data?)->(Void)){
        
        let urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!){ data, response, error in
            
            if let data = data {
                
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                print("status code:\(statusCode)")
                
                if(statusCode == 200){
                    
                    print("completed now with success response")
                
                    completionhandler(data as Data)
                    
                }
            }else if let error = error{
                
                print("An error occured")
                print(error.localizedDescription)
                completionhandler(nil)
                
            }
            
        }
        task.resume()
        
    }
    
}
