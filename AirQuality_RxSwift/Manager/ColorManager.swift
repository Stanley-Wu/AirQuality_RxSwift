//
//  ColorManager.swift
//  AppDesignPattern
//
//  Created by Stanley on 2018/2/6.
//  Copyright © 2018 mydlinksrddlink. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ColorManager {
    
    class func lightBlue() -> UIColor {
        return UIColor(red: 163, green: 191, blue: 235)
    }
    
    class func darkSilver() -> UIColor {
        return UIColor(red: 45, green: 52, blue: 49)
    }
    
    class func green() -> UIColor {
        return UIColor(red: 37, green: 230, blue: 42);
    }

    class func yellow() -> UIColor {
        return UIColor(red: 255, green: 230, blue: 0)
    }
    
    class func orange() -> UIColor {
        return UIColor(red: 253, green: 126, blue: 36)
    }
    
    class func red() -> UIColor {
        return UIColor(red: 223, green: 11, blue: 25)
    }
    
    class func purple() -> UIColor {
        return UIColor(red: 141, green: 66, blue: 148)
    }
    
    class func brown() -> UIColor {
        return UIColor(red: 124, green: 4, blue: 37)
    }
    
    class func blue() -> UIColor {
        return UIColor(red: 4, green: 173, blue: 251)
    }
    
}
