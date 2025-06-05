//
//  RealmManager.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/11/30.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    static let shared = RealmManager()
    let realm: Realm
        
    private override init() {
        // 在这里配置Realm数据库的路径和其他选项
        realm = try! Realm()
    }
}
