//
//  ViewController.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/2/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    var myLocations: [Location] = []
    
    @IBOutlet var locTableView: UITableView!
    
    lazy var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    
    func retrieveData(searchTerm:String){
        
        let api = "https://api.govote.org.ng/search?key=k9ihbvse57fvsujbsvsi5362WE$NFD2&query=\(searchTerm)"
        HttpHandler.getJSON(urlString: api, completionhandler: parseJSONData)
        
    }
    
    func parseJSONData(data : Data?) -> Void {
        
        print("parse data")
        if let data = data {
            
            let object = JSONParser.parse(data: data)
            
            if let object = object {
                
                self.myLocations = LocationdataProcessor.mapJsonToLocation(object: object,locKeys: "data")
                
                DispatchQueue.main.async {
                    self.locTableView.reloadData()
                }
                
            }
        }
        
    }
    
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
         let address = myLocations[index].address
        let location: Location = Location(id: id, name: name, area: area, address: address)
        location.address = address
        showLocationAlert(message: location.address)
        
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.characters.count > 2 {
            
            retrieveData(searchTerm: searchText)
            
        }else if searchText.characters.count<1 {
            
            retrieveData(searchTerm: "lagos")
        }
    }
  
    override func viewWillAppear(_ animated: Bool) {
        
        locTableView?.reloadData()
        
        navigationItem.title = "PVC Locations"
        
            
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
        
        retrieveData(searchTerm: "lagos")
        searchBar.placeholder = "Search for available PVC location"
        searchBar.delegate = self
        searchBar.prompt = "PVC Locations"
        searchBar.showsScopeBar = true
        searchBar.tintColor = .green
    
        navigationItem.titleView = searchBar
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }

}

