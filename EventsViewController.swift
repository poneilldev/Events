//
//  EventsViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 5/19/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
    @IBOutlet var Open: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Open.target = self.revealViewController()
        Open.action = #selector(SWRevealViewController.revealToggle(_:))

        // MARK: - UI Setup
        self.tabBarController?.tabBar.barTintColor = UIColor.backGroundBlack()
        self.tabBarController?.tabBar.tintColor = UIColor.myRed()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.myRed()]
        
        //        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<-", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToLeft")
        //        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "->", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToRight")
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let school = SchoolTableViewController()
        school.title = "SCHOOL"
        controllerArray.append(school)
        let notSchool  = NotSchoolTableViewController()
        notSchool.title = "NOT SCHOOL"
        controllerArray.append(notSchool)
        let myEvents  = MyEventsTableViewController()
        myEvents.title = "MY EVENTS"
        controllerArray.append(myEvents)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.myRed()),
            .SelectedMenuItemLabelColor(UIColor.myRed()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: self.view.frame, pageMenuOptions: parameters)
        
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.didMoveToParentViewController(self)

        
        
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
