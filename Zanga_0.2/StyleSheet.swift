//
//  StyleSheet.swift
//  Zanga_0.2
//
//  Created by Paul O'Neill on 7/29/16.
//  Copyright © 2016 Paul O'Neill. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func myRed() -> UIColor{
        return UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: 1.0)
    }
    
    class func backGroundBlack() -> UIColor {
        return UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }
    
    class func myFadedRed(alpha: CGFloat) -> UIColor {
        return UIColor(red: 255/255, green: 51/255, blue: 51/255, alpha: alpha)
    }
    
}


// MARK: Color

enum AppColor {
    
}


// MARK: Color Style

enum AppColorStyle {
    
}

// MARK: Font

enum AppFont {
    
}

// MARK: Icons

enum AppIcons: String {
    //case tabBarDiscover = "tabBarDiscover"
    case discoverEvents = "search.png"
    case savedEvents = "saved.png"
    case createEvent = "add-icon.png"
    case profile = "icon-profile.png"
    case notification = "notifications-icon.png"
    case createPublic = "publicEvent-icon.png"
    case createPrivate = "privateEvent-icon.png"
    
    func image() -> UIImage? {
        return UIImage(named: rawValue)
    }
}

// MARK: Images

enum AppImages: String {
    case PlaceHolder = "placeholder.jpg"
    // ...
    
    func image() -> UIImage? {
        return UIImage(named: rawValue)
    }
}

// MARK: TableViewCell

enum AppCellAtrributes {
    
    
}