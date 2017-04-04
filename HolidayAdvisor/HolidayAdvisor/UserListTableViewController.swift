//
//  UserListTableViewController.swift
//  HolidayAdvisor
//
//  Created by Iliyan Gogov on 4/4/17.
//  Copyright © 2017 Iliyan Gogov. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var userImage: UIImageView!
}

class UserListTableViewController: UITableViewController, HttpRequesterDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var users: [User] = []
    var animator: UIDynamicAnimator?
    var gravity: UIGravityBehavior?
    var collision: UICollisionBehavior?
    
    var url: String {
        get{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return "\(appDelegate.baseUrl)/users"
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
        
        self.gravity = UIGravityBehavior()
        self.gravity?.magnitude = 0.2
        self.collision = UICollisionBehavior()
        self.collision?.translatesReferenceBoundsIntoBoundary = true
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        self.animator?.addBehavior(self.gravity!)
        self.animator?.addBehavior(self.collision!)
        
        //let obstacle = UIView(frame: CGRect(x: 50, y : self.view.bounds.height - 100, width: self.view.bounds.width, height: 10))
        
        self.collision?.addBoundary(withIdentifier: "obstacle" as NSCopying, from: CGPoint(x:50, y:self.view.bounds.height - 100), to: CGPoint(x: self.view.bounds.width - 50, y: self.view.bounds.height - 100))
        self.loadUsers()
    }
    
    func loadUsers () {
        self.http?.delegate = self
        
        self.http?.get(fromUrl: self.url)
    }

    func didReceiveData(data: Any) {
        let dataArray = data as! [Dictionary<String, Any>]
        
        self.users = dataArray.map(){User(withDict: $0)}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        self.activityIndicator.isHidden = true
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        cell.userName?.text = self.users[indexPath.row].userName
        cell.gender?.text = self.users[indexPath.row].gender
        cell.age?.text = "\(self.users[indexPath.row].age ?? 0)"
        if let url = URL(string: self.users[indexPath.row].image!){
            
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        cell.userImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        self.gravity?.addItem(cell)
        self.collision?.addItem(cell)
        
        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
