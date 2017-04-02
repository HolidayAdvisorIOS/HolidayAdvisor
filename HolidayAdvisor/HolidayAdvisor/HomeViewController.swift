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

class HomeViewController: UITableViewController, HttpRequesterDelegate, AddPlaceModalDelegate {
    

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
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "place-cell")
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(HomeViewController.showAddModal))
        self.loadPlaces()
    }
    
    func showAddModal(){
        let nextVC = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "modal-add-place") as! AddPlaceModalViewController
        
        nextVC.delegate = self
        
//        self.customPresentViewController(self.presenter, viewController: nextVC, animated: true, completion: nil)
        
        // self.present(nextVC, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didCreatePlace(place: Place?) {
        self.places.append(place!)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
    
    func updateUI() {
        DispatchQueue.main.async {
            var yCoords: Int = 200
            for place in self.places {
                yCoords += 30
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
                label.center = CGPoint(x: 200, y: yCoords)
                label.textAlignment = .center
                label.text = place.name
                self.view.addSubview(label)
            }
            
//            self.hideLoadingScreen()
        }
    }
    
//    func showDetails(of place: Place){
//        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "book-details") as! BookDetailsViewController
//        nextVC.bookId = book.id
//        
//        self.navigationController?.show(nextVC, sender: self)
//    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceTableViewCell", for: indexPath) as! PlaceTableViewCell
        cell.placeNameLabel?.text = self.places[indexPath.row].name
        if let url = NSURL(string: self.places[indexPath.row].imageUrl!) {
            if let data = NSData(contentsOf: url as URL) {
                cell.placeImageView?.image = UIImage(data: data as Data)
            }        
        }
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.deleteBookAt(index: indexPath.row)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.showDetails(of: self.places[indexPath.row])
//    }

}

