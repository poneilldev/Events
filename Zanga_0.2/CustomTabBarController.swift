//
//  CustomTabBarController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 8/19/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class CustomTabBarController: UITabBarController {

    var toggle = true
    let publicButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    let privateButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    let publicButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 20))
    let privateButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 20))
    let createEventLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    override func viewDidAppear(animated: Bool) {

        // I'm not sure this the best way to check if user is already logged in...
        let loginEmail = NSUserDefaults.standardUserDefaults().stringForKey("email")
        let firstName = NSUserDefaults.standardUserDefaults().stringForKey("first_name")
        let lastName = NSUserDefaults.standardUserDefaults().stringForKey("last_name")
        
        if loginEmail == nil && firstName == nil && lastName == nil {
            performSegueWithIdentifier("newUser", sender: self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        let profileSB = UIStoryboard(name: "Profile", bundle: nil)
        
        let controller1 = mainSb.instantiateViewControllerWithIdentifier("DiscoverEvents")
        controller1.tabBarItem = UITabBarItem(title: "", image: AppIcons.discoverEvents.image(), tag: 1)
        controller1.tabBarItem.imageInsets.bottom = -7
        controller1.tabBarItem.imageInsets.top = 7
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = NotificationsTableViewController()
        controller2.tabBarItem = UITabBarItem(title: "", image: AppIcons.notification.image(), tag: 2)
        controller2.tabBarItem.imageInsets.bottom = -7
        controller2.tabBarItem.imageInsets.top = 7
        let nav2 = UINavigationController(rootViewController: controller2)
        
        let controller3 = UIViewController()
        controller3.view.backgroundColor = UIColor.clearColor()
        let nav3 = UINavigationController()
        nav3.title = ""
        
        let controller4 = UIViewController()
        controller4.tabBarItem = UITabBarItem(title: "", image: AppIcons.savedEvents.image(), tag: 4)
        controller4.tabBarItem.imageInsets.bottom = -6
        controller4.tabBarItem.imageInsets.top = 6
        let nav4 = UINavigationController(rootViewController: controller4)
        
        let controller5 = profileSB.instantiateViewControllerWithIdentifier("main")
        controller5.tabBarItem = UITabBarItem(title: "", image: AppIcons.profile.image(), tag: 5)
        controller5.tabBarItem.imageInsets.bottom = -7
        controller5.tabBarItem.imageInsets.top = 7
        let nav5 = UINavigationController(rootViewController: controller5)
        
        self.viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
        self.setupMiddleButton()
        
    }
    
    
    func setupMiddleButton() {
        
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = self.view.bounds.height - menuButtonFrame.height
        menuButtonFrame.origin.x = self.view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = UIColor.myRed()
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        
        self.view.addSubview(menuButton)
        
        menuButton.setImage(AppIcons.createEvent.image(), forState: UIControlState.Normal)
        menuButton.addTarget(self, action: #selector(CustomTabBarController.menuButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
        
    }
    
    func buildPublicButton() {
     
        
        createEventLabel.text = "What type of event would you like to create?"
        createEventLabel.textColor = UIColor.whiteColor()
        createEventLabel.font = UIFont(name: "HelveticaNeue-UltraLight",
                                       size: 20.0)
        createEventLabel.textAlignment = .Center
        createEventLabel.numberOfLines = 2
        createEventLabel.lineBreakMode = .ByWordWrapping
        createEventLabel.hidden = true
        
        var publicButtonLabelFrame = publicButtonLabel.frame
        publicButtonLabelFrame.origin.y = self.view.bounds.height - publicButtonLabelFrame.height - 130
        publicButtonLabelFrame.origin.x = self.view.bounds.width + 50
        publicButtonLabel.frame = publicButtonLabelFrame
        publicButtonLabel.hidden = true
        publicButtonLabel.text = "Public"
        publicButtonLabel.font.fontWithSize(3)
        publicButtonLabel.textAlignment = .Center
        publicButtonLabel.textColor = UIColor.whiteColor()
        
        var publicButtonFrame = publicButton.frame
        publicButtonFrame.origin.y = self.view.bounds.height - publicButtonFrame.height - 90
        publicButtonFrame.origin.x = self.view.bounds.width + 50// - publicButtonFrame.size.width/2
        publicButton.frame = publicButtonFrame
        publicButton.hidden = true
        
        publicButton.backgroundColor = UIColor.myRed()
        publicButton.layer.cornerRadius = publicButtonFrame.height/2
        
        self.view.addSubview(publicButton)
        self.view.addSubview(publicButtonLabel)
        self.view.addSubview(createEventLabel)
        
        publicButton.setImage(AppIcons.createPublic.image(), forState: UIControlState.Normal)
        publicButton.addTarget(self, action: #selector(CustomTabBarController.publicEventButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    func buildPrivateButton() {
        
        var privateButtonLabelFrame = privateButtonLabel.frame
        privateButtonLabelFrame.origin.y = self.view.bounds.height - privateButtonLabelFrame.height - 130
        privateButtonLabelFrame.origin.x = -self.view.bounds.width - 50
        privateButtonLabel.frame = privateButtonLabelFrame
        privateButtonLabel.hidden = true
        privateButtonLabel.text = "Private"
        privateButtonLabel.font.fontWithSize(3)
        privateButtonLabel.textAlignment = .Center
        privateButtonLabel.textColor = UIColor.whiteColor()
        
        var privateButtonFrame = privateButton.frame
        privateButtonFrame.origin.y = self.view.bounds.height - privateButtonFrame.height - 90
        privateButtonFrame.origin.x = -self.view.bounds.width - 50 //- privateButtonFrame.size.width/2
        privateButton.frame = privateButtonFrame
        privateButton.hidden = true
        
        privateButton.backgroundColor = UIColor.myRed()
        privateButton.layer.cornerRadius = privateButtonFrame.height/2
        
        self.view.addSubview(privateButton)
        self.view.addSubview(privateButtonLabel)
        
        privateButton.setImage(AppIcons.createPrivate.image(), forState: UIControlState.Normal)
        privateButton.addTarget(self, action: #selector(CustomTabBarController.privateEventButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
        
    }
    
    
    // MARK: - Actions
    
    func publicEventButtonAction(sender: UIButton) {
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: .CurveLinear, animations: {
            self.publicButtonLabel.hidden = true
            self.privateButtonLabel.hidden = true
            self.createEventLabel.hidden = true
            
            self.publicButton.frame.origin.y = self.view.bounds.height - self.publicButton.frame.height - 90
            self.publicButton.frame.origin.x = self.view.bounds.width + 50
            
            self.privateButton.frame.origin.y = self.view.bounds.height - self.privateButton.frame.height - 90
            self.privateButton.frame.origin.x = -self.view.bounds.width - 50
            }) { (finished) in
                let sb = UIStoryboard(name: "CreateEvent", bundle: nil)
                let vc = sb.instantiateViewControllerWithIdentifier("CreatePublicEventNav")
                self.presentViewController(vc, animated: true, completion: nil)
                
                if let viewWithTag = self.view.viewWithTag(100) {
                    viewWithTag.removeFromSuperview()
                }
                
                UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                    self.menuButton.transform = CGAffineTransformMakeRotation(CGFloat(0.0))
                    self.menuButton.backgroundColor = UIColor.myRed()
                    
                }) { (finished) in
                    self.enableTabBar()
                }
                self.toggle = true
        }
        
    }
    
    func privateEventButtonAction(sender: UIButton) {
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 10, initialSpringVelocity: 5, options: .CurveLinear, animations: {
            self.publicButtonLabel.hidden = true
            self.privateButtonLabel.hidden = true
            self.createEventLabel.hidden = true
            
            self.publicButton.frame.origin.y = self.view.bounds.height - self.publicButton.frame.height - 90
            self.publicButton.frame.origin.x = self.view.bounds.width + 50
            
            self.privateButton.frame.origin.y = self.view.bounds.height - self.privateButton.frame.height - 90
            self.privateButton.frame.origin.x = -self.view.bounds.width - 50
        }) { (finished) in
            let sb = UIStoryboard(name: "CreateEvent", bundle: nil)
            let vc = sb.instantiateViewControllerWithIdentifier("CreatePrivateEventNav")
            self.presentViewController(vc, animated: true, completion: nil)
            
            if let viewWithTag = self.view.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
            
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                self.menuButton.transform = CGAffineTransformMakeRotation(CGFloat(0.0))
                self.menuButton.backgroundColor = UIColor.myRed()
                
            }) { (finished) in
                self.enableTabBar()
            }
            self.toggle = true
        }
    }
    
    func menuButtonAction(sender: UIButton) {
        
        buildPublicButton()
        buildPrivateButton()
        
        displayPopOutButtons(sender)
    }
    
    
    // MARK: - Helper Functions
    
    private func displayPopOutButtons(sender: UIButton) {
        if toggle {
            disableTabBar()
            self.blurBackground(self.selectedIndex)
            
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                sender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
                sender.backgroundColor = UIColor.grayColor()
                
                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                    self.publicButton.hidden = false
                    self.publicButton.frame.origin.y = self.view.bounds.height - self.publicButton.frame.height - 90
                    self.publicButton.frame.origin.x = self.view.bounds.width/2 - self.publicButton.frame.size.width/2 + 50
                }) { (finished) in
                    
                    self.createEventLabel.frame.origin.y = self.view.bounds.height - self.createEventLabel.frame.height - 200
                    self.createEventLabel.frame.origin.x = self.view.bounds.width/2 - self.createEventLabel.frame.size.width/2
                    self.createEventLabel.hidden = false
                    
                    self.publicButtonLabel.frame.origin.y = self.view.bounds.height - self.publicButtonLabel.frame.height - 140
                    self.publicButtonLabel.frame.origin.x = self.view.bounds.width/2 - self.publicButtonLabel.frame.size.width/2 + 50
                    self.publicButtonLabel.hidden = false
                }
                
                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                    self.privateButton.hidden = false
                    self.privateButton.frame.origin.y = self.view.bounds.height - self.privateButton.frame.height - 90
                    self.privateButton.frame.origin.x = self.view.bounds.width/2 - self.privateButton.frame.size.width/2 - 50
                }) { (finished) in
                    self.privateButtonLabel.frame.origin.y = self.view.bounds.height - self.privateButtonLabel.frame.height - 140
                    self.privateButtonLabel.frame.origin.x = self.view.bounds.width/2 - self.privateButtonLabel.frame.size.width/2 - 50
                    self.privateButtonLabel.hidden = false
                }
                
            }) { (true) in
                
            }
            self.toggle = false
        } else {

            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                sender.transform = CGAffineTransformMakeRotation(CGFloat(0.0))
                sender.backgroundColor = UIColor.myRed()
                
            }) { (true) in
                self.undoBlur()
                self.enableTabBar()
                self.privateButton.hidden = true
            }
            self.toggle = true
        }
    }
    
    
    func blurBackground(index: Int) {

        let blurEffectView = UIVisualEffectView()
        blurEffectView.frame = self.view.frame
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        blurEffectView.tag = 100
        
        if let viewControllers = self.viewControllers {
            viewControllers[index].view.addSubview(blurEffectView)
            UIView.animateWithDuration(0.5, animations: {
                blurEffectView.effect = UIBlurEffect(style: .Dark)
            })
        }
        
        
    }
    
    func undoBlur() {
        if let viewWithTag = self.view.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }
    }
    
    func disableTabBar() {
        for (index,vc) in self.viewControllers!.enumerate() {
            if index != 2 {
                vc.tabBarItem.enabled = false
            }
        }
    }
    
    func enableTabBar() {
        for (index,vc) in self.viewControllers!.enumerate() {
            if index != 2 {
                vc.tabBarItem.enabled = true
            }
        }
    }
    
    

}
