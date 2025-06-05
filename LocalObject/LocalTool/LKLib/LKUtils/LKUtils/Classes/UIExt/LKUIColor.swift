//
//  LKUIColor.swift
//  LKUtils
//
//  Created by lofi on 2025/4/12.
//

import UIKit

/// 自定义颜色
extension UIColor {
    /// # 0x 自定义颜色
    class func colorWithString(_ hex: String) -> UIColor {
        return colorWithString(hex, alpha:1)
    }
    
    class func colorWithString(_ hex: String, alpha: CGFloat) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        } else if (cString.hasPrefix("0X") || cString.hasPrefix("0x")) {
            cString =  ((cString as NSString).substring(from: 2) as NSString).substring(to: 6)
        } else {
            return black
        }
        
        if ((cString as NSString).length != 6) {
            return black
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    /// 白色 - E6F0FF
    public static var meetingLightWhiteColor: UIColor {
        return colorWithString("#E6F0FF")
    }
    
    /// 蓝色 - 5591FF
    public static var meetingBlueColor: UIColor {
        return colorWithString("#5591FF")
    }
    
}
