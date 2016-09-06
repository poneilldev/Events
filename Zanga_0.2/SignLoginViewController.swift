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
import Google

var fbLoginSuccess = false
var ggLoginSuccess = false



class SignLoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet weak var fbButtonContainer: UIView!
    @IBOutlet weak var ggButtonContainer: UIView!
    @IBOutlet weak var googleIcon: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        if FBSDKAccessToken.currentAccessToken() != nil || fbLoginSuccess == true || ggLoginSuccess == true {
            performSegueWithIdentifier("LoggedIn", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.myFadedRed(5.0)
        
        var error: NSError?
        GGLContext.sharedInstance().configureWithError(&error)
        
        if error != nil {
            print(error)
            return
        }
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        let fbLoginButton = FBSDKLoginButton(frame: fbButtonContainer.bounds)
        fbLoginButton.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        fbButtonContainer.addSubview(fbLoginButton)
        fbButtonContainer.layer.cornerRadius = 10
        fbButtonContainer.clipsToBounds = true
        
        ggButtonContainer.layer.cornerRadius = 10
        ggButtonContainer.backgroundColor = UIColor(red:0.87, green:0.29, blue:0.22, alpha:1.0)
        googleIcon.layer.cornerRadius = 2
        googleIcon.layer.masksToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SignLoginViewController.googleLoginButtonPressed))
        ggButtonContainer.addGestureRecognizer(gesture)
        
        if FBSDKAccessToken.currentAccessToken() != nil {
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
    
    func googleLoginButtonPressed() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if error != nil {
            print(error)
            return
        }
        
        NSUserDefaults.standardUserDefaults().setValue(user.profile.email, forKey: "email")
        print(user.profile.email)
        
        if let imageUrl = user.profile.imageURLWithDimension(400) as? NSURL {
            let urlString = String(imageUrl)
            NSUserDefaults.standardUserDefaults().setValue(urlString, forKey: "profile_pic_url")
            print(imageUrl)
        }
        
        
        NSUserDefaults.standardUserDefaults().setValue(user.profile.givenName, forKey: "first_name")
        print(user.profile.givenName)
        
        NSUserDefaults.standardUserDefaults().setValue(user.profile.familyName, forKey: "last_name")
        print(user.profile.familyName)
        
        ggLoginSuccess = true
    }
    

}
