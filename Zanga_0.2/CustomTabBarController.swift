//
//  CustomTabBarController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 8/19/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    var toggle = true
    let publicButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))
    let privateButton = UIButton(frame: CGRect(x: 0, y: 0, width: 45, height: 45))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainSb = UIStoryboard(name: "Main", bundle: nil)
        
        let controller1 = mainSb.instantiateViewControllerWithIdentifier("DiscoverEvents")
        controller1.tabBarItem = UITabBarItem(title: "", image: AppIcons.discoverEvents.image(), tag: 1)
        controller1.tabBarItem.imageInsets.bottom = -7
        controller1.tabBarItem.imageInsets.top = 7
        let nav1 = UINavigationController(rootViewController: controller1)
        
        let controller2 = UIViewController()
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
        
        let controller5 = UIViewController() //storyBoard.instantiateViewControllerWithIdentifier("SideMenu")
        controller5.tabBarItem = UITabBarItem(title: "", image: AppIcons.profile.image(), tag: 5)
        controller5.tabBarItem.imageInsets.bottom = -7
        controller5.tabBarItem.imageInsets.top = 7
        let nav5 = UINavigationController(rootViewController: controller5)
        
        self.viewControllers = [nav1, nav2, nav3, nav4, nav5]
        
        self.setupMiddleButton()
        
    }
    
    
    func setupMiddleButton() {
        
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
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
        var publicButtonFrame = publicButton.frame
        publicButtonFrame.origin.y = self.view.bounds.height - publicButtonFrame.height - 90
        publicButtonFrame.origin.x = self.view.bounds.width + 50// - publicButtonFrame.size.width/2
        publicButton.frame = publicButtonFrame
        publicButton.hidden = true
        
        publicButton.backgroundColor = UIColor.myRed()
        publicButton.layer.cornerRadius = publicButtonFrame.height/2
        
        self.view.addSubview(publicButton)
        
        publicButton.setImage(AppIcons.discoverEvents.image(), forState: UIControlState.Normal)
        publicButton.addTarget(self, action: #selector(CustomTabBarController.publicEventButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    func buildPrivateButton() {
        var privateButtonFrame = privateButton.frame
        privateButtonFrame.origin.y = self.view.bounds.height - privateButtonFrame.height - 90
        privateButtonFrame.origin.x = -self.view.bounds.width - 50 //- privateButtonFrame.size.width/2
        privateButton.frame = privateButtonFrame
        privateButton.hidden = true
        
        privateButton.backgroundColor = UIColor.myRed()
        privateButton.layer.cornerRadius = privateButtonFrame.height/2
        
        self.view.addSubview(privateButton)
        
        privateButton.setImage(AppIcons.discoverEvents.image(), forState: UIControlState.Normal)
        privateButton.addTarget(self, action: #selector(CustomTabBarController.privateEventButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.layoutIfNeeded()
        
    }
    
    
    // MARK: - Actions
    
    func publicEventButtonAction(sender: UIButton) {
        print("Create Public Event!")
        
    }
    
    func privateEventButtonAction(sender: UIButton) {
        print("Create Private Event!")
    }
    
    
    func menuButtonAction(sender: UIButton) {
        //self.selectedIndex = 2
        buildPublicButton()
        buildPrivateButton()
        
        if toggle {
            disableTabBar()
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                sender.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
                sender.backgroundColor = UIColor.grayColor()
                
                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                    self.publicButton.hidden = false
                    self.publicButton.frame.origin.y = self.view.bounds.height - self.publicButton.frame.height - 90
                    self.publicButton.frame.origin.x = self.view.bounds.width/2 - self.publicButton.frame.size.width/2 + 50
                    
                }) { (finished) in
                    
                }
                
                UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                    self.privateButton.hidden = false
                    self.privateButton.frame.origin.y = self.view.bounds.height - self.privateButton.frame.height - 90
                    self.privateButton.frame.origin.x = self.view.bounds.width/2 - self.privateButton.frame.size.width/2 - 50
                }) { (finished) in
                    
                }
                
            }) { (true) in
                
            }
            self.toggle = false
        } else {
            UIView.animateWithDuration(0.5, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 2, options: .CurveLinear, animations: {
                sender.transform = CGAffineTransformMakeRotation(CGFloat(0.0))
                sender.backgroundColor = UIColor.myRed()
                
            }) { (true) in
                
                self.enableTabBar()
            }
            self.toggle = true
        }
    }
    
    private func displayPopOutButtons() {
    
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
