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
    
    var searchResults: [Location] = []
    
    @IBAction func search(sender: UIButton){
        
        print("Searching...")
        var searchTerm = searchText.text!
        
        if searchTerm.characters.count > 2 {
            
            retrieveData(searchTerm: searchTerm)
            
        }
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
        
        return 0.1
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
