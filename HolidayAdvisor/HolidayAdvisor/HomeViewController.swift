//
//  ViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/1/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var placesLabel: UILabel!
    var url : URL{
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return URL(fileURLWithPath: appDelegate.baseURL + "/places")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let request = NSMutableURLRequest(url: self.url)
//        request.httpMethod = "GET"
//        let session = URLSession.shared.dataTask(with: request as URLRequest){(data, response, error) in
//                let jsonData =  JSON(data: data!)
////                self.placesLabel.text = String(describing: jsonData)
//                print(jsonData)
//        }
//        session.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

