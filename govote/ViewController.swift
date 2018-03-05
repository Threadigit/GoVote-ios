//
//  ViewController.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/2/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import UIKit
import MapKit

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index: Int = indexPath.row
        
        let id = myLocations[index].id
        let name = myLocations[index].name
        let area = myLocations[index].area
        
        let location: Location = Location(id: id, name: name, area: area)
        
        showLocationAlert(message: location.area)
        
    }
    
    func showLocationAlert(message: String){
        
        let alertController = UIAlertController(title: "PVC Location", message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
            alertController.dismiss(animated: true, completion: nil)
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "View Direction", style: .default) { (action:UIAlertAction!) in
            print("open map");
            //Call another alert here
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    func showMapDirection(){
        
        
        
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
        
        navigationItem.title = "GoVote Favorites"
            
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "searchLocationSegue"{
            
            let controller = segue.destination as! SearchViewController
            controller.delegate = self
            
        }
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

