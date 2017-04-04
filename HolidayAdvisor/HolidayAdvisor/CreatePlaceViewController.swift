//
//  CreatePlaceViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/3/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit

class CreatePlaceViewController: UIViewController, HttpRequesterDelegate {

    @IBOutlet weak var placeNameLabel: UITextField!
    @IBOutlet weak var placeOwnerLabel: UITextField!
    @IBOutlet weak var placeDescriptionLabel: UITextField!
    @IBOutlet weak var placeImageUrlLabel: UITextField!
    
    var name : String? = ""
    var imageUrl: String? = ""
    var info: String? = ""
    var owner: String? = ""
    var rating: Int? = 0

    
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmitButtonClick(_ sender: Any) {
        var name: String = self.placeNameLabel.text!
        var description: String = self.placeDescriptionLabel.text!
        var imageUrl: String = self.placeImageUrlLabel.text!
        var owner: String = self.placeOwnerLabel.text!
        
        func placeToCreate() -> Dictionary<String, Any> {
            return[
                "owner": owner,
                "info": description,
                "img": imageUrl,
                "name": name,
                "rating":3,
                "lat":0,
                "lng":0]
        }
        
        self.http?.delegate? = self
        
        self.http?.postJson(toUrl: self.url, withBody: placeToCreate())
        
        
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SuccessCreatedView") as! SuccessCreatedViewController

        destination.name = name
        destination.owner = owner
        
        self.show(destination, sender: self)

    }
    
    func didReceiveData(data: Any) {
        let dataObj = data as! Dictionary<String, Any>
        
        self.name = dataObj["name"] as? String
        self.imageUrl = dataObj["img"] as? String
        self.info = dataObj["info"] as? String
        self.owner = dataObj["owner"] as? String
        self.rating = dataObj["rating"] as? Int
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
