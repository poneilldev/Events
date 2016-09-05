//
//  SignLoginViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 8/30/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import FBSDKCoreKit

var fbLoginSuccess = false

let fbLoginButton: FBSDKLoginButton = {
    let button = FBSDKLoginButton()
    button.readPermissions = ["email"]
    return button
}()

class SignLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil || fbLoginSuccess == true {
            performSegueWithIdentifier("LoggedIn", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.myFadedRed(5.0)
        
        fbLoginButton.center = self.view.center
        fbLoginButton.delegate = self
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fbLoginButton)
        fbLoginButton.layer.cornerRadius = 30
        
        let horizontalConstraint = fbLoginButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        let verticalConstraint = fbLoginButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -50)
        let widthConstraint = fbLoginButton.widthAnchor.constraintEqualToAnchor(nil, constant: view.frame.width - 30)
        let heightConstraint = fbLoginButton.heightAnchor.constraintEqualToAnchor(nil, constant: 60)
        NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        
        if let token = FBSDKAccessToken.currentAccessToken() {
            fetchProfile()
        }
    }
    
    
    // MARK: Facebook
    
    func fetchProfile() {
        print("fetch profile")
        
        let parameters = ["fields": "email, first_name, last_name, picture.type(large)"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).startWithCompletionHandler { (connection, result, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            if let email = result["email"] as? String {
                print(email)
                NSUserDefaults.standardUserDefaults().setValue(email, forKey: "email")
            }
            
            if let first_name = result["first_name"] as? String, last_name = result["last_name"] as? String {
                NSUserDefaults.standardUserDefaults().setValue(first_name, forKey: "first_name")
                NSUserDefaults.standardUserDefaults().setValue(last_name, forKey: "last_name")
                print(first_name + " " + last_name)
            }
            
            if let picture = result["picture"] as? NSDictionary, data = picture["data"] as? NSDictionary, url = data["url"] as? String {
                print(url)
                NSUserDefaults.standardUserDefaults().setValue(url, forKey: "profile_pic_url")
            }
            
            fbLoginSuccess = true
        }
    }
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("Completed FB Login")
        fetchProfile()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    

}






//    func signUpButtonHighlight() {
//        signUpButton.backgroundColor = UIColor.whiteColor()
//    }
//
//    func signUpButtonNormal() {
//        signUpButton.backgroundColor = UIColor.myRed()
//    }


//        signUpButton.backgroundColor = UIColor.clearColor()
//        signUpButton.layer.borderWidth = 1.0
//        signUpButton.layer.cornerRadius = signUpButton.frame.height/2
//        signUpButton.layer.borderColor = UIColor.whiteColor().CGColor
//        signUpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        signUpButton.setTitleColor(UIColor.myRed(), forState: .Highlighted)
//
//        signUpButton.addTarget(self, action: #selector(SignLoginViewController.signUpButtonHighlight), forControlEvents: .TouchDown)
//        signUpButton.addTarget(self, action: #selector(SignLoginViewController.signUpButtonNormal), forControlEvents: .TouchUpInside)
//        signUpButton.addTarget(self, action: #selector(SignLoginViewController.signUpButtonNormal), forControlEvents: .TouchDragExit)
//
//        LoginButton.backgroundColor = UIColor.whiteColor()
//        LoginButton.layer.borderWidth = 1.0
//        LoginButton.layer.cornerRadius = LoginButton.frame.height/2
//        LoginButton.layer.borderColor = UIColor.whiteColor().CGColor
//        LoginButton.setTitleColor(UIColor.myRed(), forState: .Normal)
//        LoginButton.setTitleColor(UIColor.whiteColor(), forState: .Selected)
