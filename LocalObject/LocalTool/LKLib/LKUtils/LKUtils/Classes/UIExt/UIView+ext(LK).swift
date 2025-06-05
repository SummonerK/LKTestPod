//
//  UIView+ext(LK).swift
//  LKUtils
//
//  Created by lofi on 2024/11/30.
//

import Foundation
import UIKit

public let kscreenW = UIScreen.main.bounds.size.width
public let kscreenH = UIScreen.main.bounds.size.height

extension UIView {
    /// 加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    static func safeAreaInsets () -> UIEdgeInsets {
        guard #available(iOS 11.0, *), let safeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets else {
            return UIEdgeInsets()
        }
        return safeAreaInsets
    }
}
