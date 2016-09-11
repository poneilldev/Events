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
    @IBOutlet weak var pageMenuContainerView: UIView!
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.barTintColor = UIColor.backGroundBlack()
        self.tabBarController?.tabBar.tintColor = UIColor.myRed()
        self.navigationController?.navigationBar.translucent = false
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.myRed()]
        
        
        self.view.tintColor = UIColor.myRed()
        self.view.backgroundColor = UIColor.blackColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.backGroundBlack()
        let button = UIButton(type: .Custom)
        button.setImage(AppIcons.settings.image(), forState: .Normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        //button.imageView?.clipsToBounds = true
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
        
        
        // MARK: pageMenu
        
        var controllerArray : [UIViewController] = []
        
        let sb = UIStoryboard(name: "Profile", bundle: nil)
        
        let friendsPage = UITableViewController()
        friendsPage.view.backgroundColor = UIColor.blackColor()
        friendsPage.title = "FRIENDS"
        controllerArray.append(friendsPage)
        
        let myEventsPage = UITableViewController()
        myEventsPage.view.backgroundColor = UIColor.blackColor()
        myEventsPage.title = "MY EVENTS"
        controllerArray.append(myEventsPage)
        
//        let otherPage = UITableViewController()
//        otherPage.view.backgroundColor = UIColor.blackColor()
//        otherPage.title = "OTHER PAGE"
//        controllerArray.append(otherPage)
        
//        let otherPage2 = UITableViewController()
//        otherPage2.view.backgroundColor = UIColor.blackColor()
//        otherPage2.title = "OTHER PAGE2"
//        controllerArray.append(otherPage2)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.myRed()),
            .SelectedMenuItemLabelColor(UIColor.myRed()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(180.0),
            .CenterMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: pageMenuContainerView.bounds, pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        pageMenuContainerView.addSubview(pageMenu!.view)
        pageMenu!.didMoveToParentViewController(self)
        
    }
    
    

}
