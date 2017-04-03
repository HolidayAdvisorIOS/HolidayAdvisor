//
//  ViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/1/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit
import SwiftyJSON

class PlaceTableViewCell: UITableViewCell{
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var placeImageView: UIImageView!
}

class HomeViewController: UITableViewController, HttpRequesterDelegate {
    

    var placeId: String?
    var places: [Place] = []
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/places"
        }
    }
    
    var http: HttpRequester? {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: "PlaceTableViewCell")
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(self.createPlace))
        self.loadPlaces()
    }
    
   func createPlace () {
    let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreatePlaceView") as! CreatePlaceViewController
    self.show(destination, sender: self)
    }
    
//    func showAddModal(){
//        let nextVC = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewController(withIdentifier: "modal-add-place") as! AddPlaceModalViewController
//        
//        nextVC.delegate = self
//        
////        self.customPresentViewController(self.presenter, viewController: nextVC, animated: true, completion: nil)
//        
//        // self.present(nextVC, animated: true, completion: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPlaces () {
        self.http?.delegate = self
        //self.showLoadingScreen()
        
        self.http?.get(fromUrl: self.url)
    }
    
    func didReceiveData(data: Any) {
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.places = dataArray.map(){Place(withDict: $0)}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            //self.hideLoadingScreen()
        }
        //self.updateUI()
    }
    
//    func updateUI() {
//        DispatchQueue.main.async {
//            var yCoords: Int = 200
//            for place in self.places {
//                yCoords += 30
//                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
//                label.center = CGPoint(x: 200, y: yCoords)
//                label.textAlignment = .center
//                label.text = place.name
//                self.view.addSubview(label)
//            }
//            
////            self.hideLoadingScreen()
//        }
//    }
    
    func showDetails(of place: Place){
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlaceDetailsView") as! PlaceDetailsViewController
        
        destination.name = place.name
        destination.imageUrl = place.imageUrl!
        destination.info = place.info
        destination.owner = place.owner

        self.show(destination, sender: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All places you should visit"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        cell.placeNameLabel?.text = self.places[indexPath.row].name
        if let url = URL(string: self.places[indexPath.row].imageUrl!){
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.placeImageView.image = UIImage(data: data)
                    }
                }
            }
        }
//        DispatchQueue.main.async {
//        if let url = NSURL(string: self.places[indexPath.row].imageUrl!) {
//            if let data = NSData(contentsOf: url as URL) {
//            cell.placeImageView.contentMode = .scaleAspectFit
//                cell.placeImageView?.image = UIImage(data: data as Data)
//            }        
//        }
//        }
        cell.setNeedsLayout() //invalidate current layout
        cell.layoutIfNeeded() //update immediately
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    
//     //Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.deletePlaceAt(index: indexPath.row)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(of: self.places[indexPath.row])
        
    }

}

