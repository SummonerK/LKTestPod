//
//  WeakArray.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/12/10.
//

import Foundation

class WeakArray<T: AnyObject> {
    private var array: [Weak<T>] = []
    
    func append(_ object: T?) {
        if let object = object {
            array.append(Weak(object))
        }
    }
    
    func remove(_ object: T?) {
        if let object = object, let index = array.firstIndex(where: { $0.value === object }) {
            array.remove(at: index)
        }
    }
    
    //清除无效对象
    func compact() {
        array = array.filter { $0.value != nil }
    }
    
    func allObjects() -> [T] {
        return array.compactMap { $0.value }
    }
    
    var count:Int{
        array.count
    }
}

// 定义一个包装弱引用的类
class Weak<T: AnyObject> {
    weak var value: T?
    
    init(_ value: T?) {
        self.value = value
    }
}
