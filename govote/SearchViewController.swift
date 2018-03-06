//
//  SearchViewController.swift
//  govote
//
//  Created by Adetuyi Tolu Emmanuel on 3/3/18.
//  Copyright © 2018 Adetuyi Tolu Emmanuel. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var locationTable: UITableView!
    @IBOutlet var searchText: UITextField!
    
    weak var delegate: ViewController!
    
    var searchResults: [Location] = []
    
    @IBAction func search(sender: UIButton){
        
        print("Searching...")
        var searchTerm = searchText.text!
        
        if searchTerm.characters.count > 2 {
            
            retrieveData(searchTerm: searchTerm)
            
        }
    }
    
    @IBAction func addFav(sender: UIButton){
        
        self.delegate.myLocations.append(searchResults[sender.tag])
        print("item selected is: \(sender.tag)")
        
    }
    
    func retrieveData(searchTerm:String){
        
        let api = "https://api.govote.org.ng/search?key=k9ihbvse57fvsujbsvsi5362WE$NFD2&query=\(searchTerm)"
        HttpHandler.getJSON(urlString: api, completionhandler: parseJSONData)
        
    }
    
    func parseJSONData(data : Data?) -> Void {
        
        print("parse data")
        if let data = data {
            
            let object = JSONParser.parse(data: data)
            
            if let object = object {
                
                self.searchResults = LocationdataProcessor.mapJsonToLocation(object: object,locKeys: "data")
                
                DispatchQueue.main.async {
                    self.locationTable.reloadData()
                }
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Search Results"
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        //group vertical sections of the tableview
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let locationCell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
            as! LocTableViewCell
        let index: Int = indexPath.row
        
        locationCell.favBtn.tag = index
        
        locationCell.locationName?.text = searchResults[index].name
        locationCell.locationArea?.text = searchResults[index].area
        displayUserImage(index,locationCell: locationCell)
        return locationCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index: Int = indexPath.row
        
        let id = searchResults[index].id
        let name = searchResults[index].name
        let area = searchResults[index].area
        let address = searchResults[index].address
        
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
    
    func displayUserImage(_ row:Int,locationCell:LocTableViewCell){
        
        let imageURL = (URL(string :searchResults[row].imgURL)?.absoluteString)!
        
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
