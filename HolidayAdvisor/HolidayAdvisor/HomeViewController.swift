//
//  ViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/1/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell{
    
    @IBOutlet weak var placeNameLabel: UILabel!
    
    @IBOutlet weak var placeImageView: UIImageView!
}

class HomeViewController: UITableViewController, HttpRequesterDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var places: [Place] = []
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    
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
        self.gravity = UIGravityBehavior()
        self.collision = UICollisionBehavior()
        self.collision?.translatesReferenceBoundsIntoBoundary = true
        
        self.animator = UIDynamicAnimator(referenceView: self.view)

        self.animator?.addBehavior(self.gravity!)
        self.animator?.addBehavior(self.collision!)
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadPlaces () {
        self.http?.delegate = self
        
        self.http?.get(fromUrl: self.url)
    }
    
    func didReceiveData(data: Any) {
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.places = dataArray.map(){Place(withDict: $0)}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.activityIndicator.isHidden = true
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
////
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
        
      
//        self.gravity?.addItem(cell)
//        self.collision?.addItem(cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.showDetails(of: self.places[indexPath.row])
    }

}

