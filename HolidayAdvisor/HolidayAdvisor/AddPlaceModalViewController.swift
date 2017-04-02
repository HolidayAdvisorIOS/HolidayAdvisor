//
//  AddPlaceModalViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/2/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import Foundation
import UIKit

protocol AddPlaceModalDelegate {
    func didCreatePlace(place: Place?)
}

class AddPlaceModalViewController: UIViewController, HttpRequesterDelegate {
    @IBOutlet weak var textTitle: UITextField!
    @IBOutlet weak var textDescription: UITextView!
    
    var delegate: AddPlaceModalDelegate?
    
    var url: String {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/places"
        }
    }
    
    var http: HttpRequester? {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.http
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.http?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        let title = self.textTitle.text
        let description = self.textDescription.text
        
        let place = Place(withName: title!,imageUrl:"", andInfo: description!)
        let placeDict = place.toDict()
        
        self.http?.postJson(toUrl: self.url, withBody: placeDict)
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func didReceiveData(data: Any) {
        let dict = data as! Dictionary<String, Any>
        let place = Place(withDict: dict)
        self.delegate?.didCreatePlace(place: place)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func didReceiveError(error: HttpError) {
        print(error)
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
