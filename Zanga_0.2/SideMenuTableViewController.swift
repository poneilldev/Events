//
//  SideMenuTableViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 5/21/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    // Profile
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    // Static
    @IBOutlet weak var profileSettingsPic: UIImageView!
    @IBOutlet weak var changeCollegePic: UIImageView!
    @IBOutlet weak var contactUsPic: UIImageView!
    @IBOutlet weak var sharePic: UIImageView!
    @IBOutlet weak var logoutPic: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        self.tableView.backgroundView?.backgroundColor = UIColor.blackColor()
        self.tableView.allowsSelection = false
        
        profilePic.image = UIImage(named: "icon-profile.png")
        userNameLabel.text = "Paul O'Neill"
        
        profileSettingsPic.image = UIImage(named: "icon-profile.png")
        changeCollegePic.image = UIImage(named: "icon-profile.png")
        contactUsPic.image = UIImage(named: "icon-profile.png")
        sharePic.image = UIImage(named: "icon-profile.png")
        logoutPic.image = UIImage(named: "icon-profile.png")
        
        
        
        //tableView.registerNib(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuTVC")
        
    }
    
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }
//    
//
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//
////        let cell = tableView.dequeueReusableCellWithIdentifier("sideMenuTVC", forIndexPath: indexPath) as! SideMenuTableViewCell
////
////        cell.profileName.text = "Paul O'Neill"
////        cell.profilePic.image = UIImage(named: "icon-profile.png")
////        
//        return cell
//    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
