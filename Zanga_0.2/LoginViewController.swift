//
//  LoginViewController.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 8/30/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper // Save password to KeyChain


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    @IBOutlet weak var FBButton: UIButton!
    @IBOutlet weak var GPButton: UIButton!
    @IBOutlet weak var TWButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hasLogin = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
        
        if hasLogin {
            SignUpButton.setTitle("LOGIN", forState: .Normal)
            SignUpButton.tag = loginButtonTag
            
        } else {
            SignUpButton.setTitle("CREATE", forState: .Normal)
            SignUpButton.tag = createLoginButtonTag
            
        }
        
        if let storedUsername = NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            emailTextField.text = storedUsername as String
        }
        
        
        self.view.backgroundColor = UIColor.backGroundBlack()
        
        let border1 = CALayer()
        let width1 = CGFloat(2.0)
        border1.borderColor = UIColor.myFadedRed(1.0).CGColor
        border1.frame = CGRect(x: 0, y: emailTextField.frame.size.height - width1, width:  emailTextField.frame.size.width, height: emailTextField.frame.size.height)
        
        border1.borderWidth = width1
        emailTextField.layer.addSublayer(border1)
        emailTextField.layer.masksToBounds = true
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSForegroundColorAttributeName: UIColor.myFadedRed(0.5)])
        
        let border2 = CALayer()
        let width2 = CGFloat(2.0)
        border2.borderColor = UIColor.myFadedRed(1.0).CGColor
        border2.frame = CGRect(x: 0, y: passTextField.frame.size.height - width2, width:  passTextField.frame.size.width, height: passTextField.frame.size.height)

        border2.borderWidth = width2
        passTextField.layer.addSublayer(border2)
        passTextField.layer.masksToBounds = true
        passTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSForegroundColorAttributeName: UIColor.myFadedRed(0.5)])
        
        
        FBButton.layer.cornerRadius = FBButton.frame.height/2
        
        GPButton.layer.cornerRadius = GPButton.frame.height/2
        
        TWButton.layer.cornerRadius = TWButton.frame.height/2
        
        
        SignUpButton.layer.cornerRadius = SignUpButton.frame.height/2
        SignUpButton.backgroundColor = UIColor.clearColor()
        SignUpButton.setTitleColor(UIColor.myRed(), forState: .Normal)
        SignUpButton.layer.borderColor = UIColor.myRed().CGColor
        SignUpButton.layer.borderWidth = 1.0
        SignUpButton.addTarget(self, action: #selector(LoginViewController.loginAction), forControlEvents: .AllTouchEvents)
        
        
        
        fbLoginButton.delegate = self
        fbLoginButton.center = self.view.center
        self.view.addSubview(fbLoginButton)
        
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
                NSUserDefaults.standardUserDefaults().setValue(url, forKey: "pic_url")
            }
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
    
    
    
    func loginAction() {
        if (emailTextField.text == "" || passTextField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Cancel", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        emailTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        
        
        if SignUpButton.tag == createLoginButtonTag {
            let hasLoginKey = NSUserDefaults.standardUserDefaults().boolForKey("hasLoginKey")
            if hasLoginKey == false {
                NSUserDefaults.standardUserDefaults().setValue(self.emailTextField.text, forKey: "username")
            }
            
            if let password = self.passTextField.text {
                let saveSuccessful = KeychainWrapper.setString(password, forKey: kSecValueData as String)
                NSUserDefaults.standardUserDefaults().setBool(saveSuccessful, forKey: "hasLoginKey")
                NSUserDefaults.standardUserDefaults().synchronize()
                SignUpButton.tag = loginButtonTag
            }
            
            
            performSegueWithIdentifier("login", sender: self)
        } else if SignUpButton.tag == loginButtonTag {
            if checkLogin(emailTextField.text!, password: passTextField.text!) {
                performSegueWithIdentifier("login", sender: self)
            } else {
                let alertView = UIAlertController(title: "Login Problem",
                                                  message: "Wrong username or password." as String, preferredStyle:.Alert)
                let okAction = UIAlertAction(title: "Foiled Again!", style: .Default, handler: nil)
                alertView.addAction(okAction)
                self.presentViewController(alertView, animated: true, completion: nil)

            }
        }
    }
    
    func checkLogin(username: String, password: String ) -> Bool {
        if password == KeychainWrapper.stringForKey("v_Data") &&
            username == NSUserDefaults.standardUserDefaults().valueForKey("username") as? String {
            return true
        } else {
            return false
        }
    }
    
    func loginFB() {
        
    }
    
    func loginGP() {
        
    }
    
    func loginTW() {
        
    }
    

}
