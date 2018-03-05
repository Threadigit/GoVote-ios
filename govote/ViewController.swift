//
//  ViewController.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/2/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var myLocations: [Location] = []
    
    @IBOutlet var locTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
            as! LocTableViewCell
        let index: Int = indexPath.row
        
        locationCell.locationName?.text = myLocations[index].name
        locationCell.locationArea?.text = myLocations[index].area
        displayUserImage(index,locationCell: locationCell)
        return locationCell
        
    }
    
    func displayUserImage(_ row:Int,locationCell:LocTableViewCell){
        
        let imageURL = (URL(string :myLocations[row].imgURL)?.absoluteString)!
        
        URLSession.shared.dataTask(with: URL(string: imageURL)!,completionHandler:{(
            data, response, error)-> Void in
            
            if error != nil{
                
                print(error!)
                
            }else{
          
                DispatchQueue.main.async (execute: {
                    
                    let image = UIImage(data: data!)
                    locationCell.locationImageView?.image = image
                    
                })
                
            }
        }).resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        locTableView?.reloadData()
        
        if(myLocations.count == 0){
            
            let loc: Location = Location(id: 1, name: "Lagos", area: "Maryland")
            myLocations.append(loc)
            myLocations.append(loc)
            myLocations.append(loc)
            
        }
        
        navigationItem.title = "GoVote"
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

