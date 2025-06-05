//
//  JKTestVC.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/10/17.
//

import UIKit
import JKSwiftExtension

@objcMembers
open class JKTestVC: UIViewController {
    let myStr:String = ""  /// 是字符串啊

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lkRandomColor(0.5);

        self.view.jk.addActionClosure { _,_,_ in
            let vc = LKFontIconBookVC()
            print("hello jk \(10086)")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
