//
//  SuccessCreatedViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/3/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit

class SuccessCreatedViewController: UIViewController {

    @IBOutlet weak var placeNameLabel: UILabel!
    
    var name: String = ""
    var owner: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeNameLabel.text = "Congratulasions \(self.owner) you just shared place: \(self.name)"
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
