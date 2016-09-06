//
//  PersonalProfileViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 5/20/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class PersonalProfileViewController: UIViewController {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var profileName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.blackColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.backGroundBlack()
        let button = UIButton(type: .Custom)
        button.imageView?.image = AppIcons.settings.image()
        button.imageView?.clipsToBounds = true
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
        
        if let picUrl = NSUserDefaults.standardUserDefaults().stringForKey("profile_pic_url") {
            profilePic.sd_setImageWithURL(NSURL(string: picUrl))
        }
        
        
        if let firstName = NSUserDefaults.standardUserDefaults().stringForKey("first_name"),
            lastName = NSUserDefaults.standardUserDefaults().stringForKey("last_name") {
            profileName.text = firstName + " " + lastName
        }
        
        self.view.tintColor = UIColor.myRed()
    }
    
    

}
