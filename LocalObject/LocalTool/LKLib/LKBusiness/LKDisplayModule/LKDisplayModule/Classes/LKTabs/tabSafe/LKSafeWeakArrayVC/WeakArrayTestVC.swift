//
//  WeakArrayTestVC.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/12/10.
//

import UIKit

@objc public class WeakArrayTestVC: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()

        let weakArray = WeakArray<NSObject>()
        var object1: NSObject? = NSObject()
        let object2: NSObject? = NSObject()

        weakArray.append(object1)
        weakArray.append(object2)

        // object1 被释放，并从 weakArray 中移除
        object1 = nil

        let objects = weakArray.allObjects() // 获取当前数组中的有效对象

        print("weakArray count:\(weakArray.count)")
        print("objects count：\(objects.count)")
        print("objects: \(objects)")
    }

}
