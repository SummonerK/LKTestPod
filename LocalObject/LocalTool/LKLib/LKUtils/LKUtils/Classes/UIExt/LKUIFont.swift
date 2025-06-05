//
//  LKUIFont.swift
//  LKUtils
//
//  Created by lofi on 2025/4/12.
//

import UIKit

/// 屏幕宽度
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 宽度比例
let widthScale: CGFloat =  CGFloat(SCREEN_WIDTH / 375)

extension UIFont {
    public static func pingFangRegular(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Regular", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }
    
    public static func pingFangMedium(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Medium", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }

    public static func pingFangSemibold(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Semibold", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }
    
    public static func pingFangLight(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Light", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }
    
    public static func pingFangThin(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Thin", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }
    
    public static func pingFangUltralight(_ size: CGFloat, _ shouldScale: Bool = true) -> UIFont {
        let setSize = shouldScale ?(size * widthScale):size
        guard let font = UIFont(name: "PingFangSC-Ultralight", size: setSize) else {
            return UIFont.systemFont(ofSize: setSize)
        }
        return font
    }
}
