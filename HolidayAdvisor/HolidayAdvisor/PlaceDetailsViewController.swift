//
//  PlaceDetailsViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/3/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit

class PlaceDetailsViewController: UIViewController {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    var name : String? = ""
    var imageUrl: String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.placeNameLabel.text = self.name
                if let url = NSURL(string: self.imageUrl) {
                    if let data = NSData(contentsOf: url as URL) {
                        self.placeImage?.image = UIImage(data: data as Data)
                    }
                }
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
