//
//  CreateEventViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 5/19/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextArea: UITextView!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var inviteFriendsButton: UIButton!
    @IBOutlet weak var createEvent: UIButton!
    @IBOutlet weak var cancelForm: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.setValue(UIColor.whiteColor(), forKey: "textColor")
        self.tabBarController?.tabBar.barTintColor = UIColor.backGroundBlack()
        self.tabBarController?.tabBar.tintColor = UIColor.myRed()
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.backgroundColor = UIColor.backGroundBlack()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.myRed()]
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
