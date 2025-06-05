//
//  LKModelCommonBase.swift
//  LKDisplayModule
//
//  Created by lofi on 2025/5/9.
//

import UIKit

protocol LKModelCommonBaseProperty {
    var baseCheck: Bool { get set }
}

class LKModelCommonBase: NSObject, LKModelCommonBaseProperty {
    var baseCheck: Bool = false
}


/*
 Swift 协议（Protocol）是 Swift 编程语言中的一种类型，它定义了一个蓝图，规定了某些方法、属性或其它需求的实现。协议可以被类（Class）、结构体（Struct）或枚举（Enum）采纳并实现这些需求。通过使用协议，你可以实现多种设计模式，比如多态、依赖注入等，并且能够写出更加灵活和可重用的代码。
 以下是关于 Swift 协议的一些关键点：
 1. 定义协议：使用 protocol 关键字来定义一个协议。
 protocol SomeProtocol {
     // 协议内容
 }

 2. 属性要求：协议可以要求遵循它的类型提供特定的实例属性或类型属性。例如：
 protocol SomeProtocol {
     var mustBeSet: Int { get set }  // 必须有 getter 和 setter
     var onlyNeedGetter: Int { get } // 只需要有 getter
 }

 3. 方法要求：协议可以要求遵循它的类型提供特定的实例方法或类型方法。
 protocol SomeProtocol {
     func doSomething()
 }

 4. ** mutating 方法**：如果协议中的方法需要修改遵循该协议的类型的数据，那么就需要在方法前加上 mutating 关键字。
 protocol Togglable {
     mutating func toggle()
 }

 enum OnOffSwitch: Togglable {
     case off, on
     mutating func toggle() {
         switch self {
         case .off:
             self = .on
         case .on:
             self = .off
         }
     }
 }

 5. 初始化器要求：协议可以要求遵循它的类型提供特定的初始化器。
 protocol SomeProtocol {
     init(someParameter: Int)
 }

 6. 协议继承：一个协议可以继承一个或多个其他协议，并可以在其基础上添加更多的要求。
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
     // 新增的需求
 }

 7. 类专属协议：有时我们只想让类类型遵循某个协议，这时可以在协议名后添加 class 关键字。
 protocol SomeClassOnlyProtocol: class {
     // 类专属协议的内容
 }

 8. 协议合成：你可以在需要时将多个协议组合成一个新的协议类型。
 func someFunction<T: ProtocolA & ProtocolB>(someT: T) {
     // 函数内容
 }

 9. 检查协议一致性：可以使用 is 和 as 来检查一个类型是否遵循某个协议以及将它转换为该协议类型。
 protocol HasArea {
     var area: Double { get }
 }

 class Circle: HasArea {
     let radius: Double
     var area: Double { return .pi * radius * radius }
     init(radius: Double) { self.radius = radius }
 }

 let objects: [AnyObject] = [
     Circle(radius: 2.0),
     "This is not a circle"
 ]

 for object in objects {
     if let circle = object as? HasArea {
         print("Area is \(circle.area)")
     } else {
         print("Not a circle")
     }
 }

 10. 可选协议要求（不推荐）：虽然可以通过 @objc 和 optional 来创建可选的协议要求，但这种方式并不推荐，因为它与 Swift 的本质相违背。尽量避免使用可选要求，而应该使用协议组合或者扩展来达到类似效果。
 以上就是 Swift 中协议的基本概念和使用方法。如果你有任何具体的问题或者需要更详细的解释，请随时告诉我！

*/
