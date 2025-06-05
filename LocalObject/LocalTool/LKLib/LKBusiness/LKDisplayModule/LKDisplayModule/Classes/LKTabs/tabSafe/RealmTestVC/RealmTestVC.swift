//
//  RealmTestVC.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/11/30.
//

import UIKit
import LKUtils
import RealmSwift

@objc public enum LKBaseItemJumpType: Int {
    case lkFunc
    case lkVC
}

@objc public class LKBaseSection: NSObject {
    var title: String?
    var items: Array<LKBaseItem>?
    @objc public init(title: String, items: Array<LKBaseItem>) {
        self.title = title
        self.items = items
    }
}

@objc public class LKBaseItem: NSObject {
    var title: String?
    var subTitle: String?
    var jumpType: LKBaseItemJumpType?
    var jumpValue: String?
    @objc public init(title: String, subTitle: String, jumpType: LKBaseItemJumpType, jumpValue: String) {
        self.title = title
        self.subTitle = subTitle
        self.jumpType = jumpType
        self.jumpValue = jumpValue
    }
}

/// 测试Model
@objc class Person: Object {
    @Persisted var userId: String = ""
    @Persisted var name: String?
    @Persisted var date: String?
    @Persisted var age: Int = 0
    
//    //设置主键
//    override class func primaryKey() -> String? {
//
//    }
}

@objc public class RealmTestVC: UIViewController {
    var tableV_main:UITableView!
    var arrayList:Array<LKBaseSection> = []

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        createData()
    }
    
    func initTableView() -> Void {
        let safeInsets = self.view.safeAreaInsets
        let mainView_Y:CGFloat = safeInsets.top + 44
        let mainView_H:CGFloat = kscreenH - mainView_Y - safeInsets.bottom
        let mainView_W:CGFloat = kscreenW
        tableV_main = UITableView.init(frame: CGRect.init(x: 0, y: mainView_Y, width: mainView_W, height:mainView_H))
        view.addSubview(tableV_main)
        setupTableView()
    }
    func setupTableView() -> Void {
        tableV_main.delegate = self
        tableV_main.dataSource = self
        tableV_main.jk.register(cellClass: UITableViewCell.self)
        tableV_main.backgroundColor = .white
        tableV_main.showsVerticalScrollIndicator = false
        tableV_main.showsHorizontalScrollIndicator = false
        tableV_main.separatorStyle = .singleLine
        tableV_main.alwaysBounceVertical = true
        tableV_main.bounces = false
        tableV_main.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        if #available(iOS 15.0, *) {
            tableV_main.sectionHeaderTopPadding = 0
        } else {
            // Fallback on earlier versions
        }
    }
    
    func createData() -> Void {
        let arrayData:NSMutableArray = NSMutableArray()
        let sectionModel = LKBaseSection(title: "测试一些方法", items: mockItemList())
        arrayData.add(sectionModel)
        arrayList = arrayData.copy() as! Array<LKBaseSection>
        tableV_main.reloadData()
    }
    
    func mockItemList() -> Array<LKBaseItem> {
        return [
            LKBaseItem(title: "新增一个对象", subTitle: "Realm_dataAdd", jumpType: .lkFunc, jumpValue: "testRealm_dataAdd"),
            LKBaseItem(title: "查询一个对象", subTitle: "Realm_dataRead", jumpType: .lkFunc, jumpValue: "testRealm_dataRead"),
            LKBaseItem(title: "修改一个对象", subTitle: "Realm_dataChange", jumpType: .lkFunc, jumpValue: "testRealm_dataChange"),
            LKBaseItem(title: "删除一个对象", subTitle: "Realm_dataRemove", jumpType: .lkFunc, jumpValue: "testRealm_dataRemove")
        ]
    }
}

extension RealmTestVC {
    
    func testRealm_set() -> Void {
        let realm = RealmManager.shared.realm
    }
    
    @objc func testRealm_dataAdd() -> Void {
        let realm = RealmManager.shared.realm
        let person = Person()
        person.name = "袁神～启动"
        person.userId = "62b27e96b664d63f06c9403880e149e4"
        person.date = Date().jk.toformatterTimeString()
        person.age = 3
        try! realm.write {
            realm.add(person)
        }
    }
    
    @objc func testRealm_dataRemove() -> Void {
        let realm = RealmManager.shared.realm
        var searchResult:Person?
        searchResult = realm.objects(Person.self).filter("userId = '62b27e96b664d63f06c9403880e149e4'").first
        guard let searchResult = searchResult else { return }
        try! realm.write {
            realm.delete(searchResult)
        }
    }
    
    @objc func testRealm_dataChange() -> Void {
        let realm = RealmManager.shared.realm
        var searchResult:Person?
        searchResult = realm.objects(Person.self).filter("userId = '62b27e96b664d63f06c9403880e149e4'").first
        searchResult?.name = "小黑子XXX"
        guard let searchResult = searchResult else { return }
//        searchResult.name = "小黑子XXX"
        do {
            try realm.write {
                realm.add(searchResult, update: .all)
            }
        } catch _ {
            assert(false,"修改失败")
        }
    }
    
    @objc func testRealm_dataRead() -> Void {
        let realm = RealmManager.shared.realm
        var searchResult:Person?
        let results = realm.objects(Person.self).filter("userId = '62b27e96b664d63f06c9403880e149e4'")
        searchResult = realm.objects(Person.self).filter("userId = '62b27e96b664d63f06c9403880e149e4'").first
        print("查询到该「小黑子」名字是===\(searchResult?.name ?? "")")
    }
    
}

extension RealmTestVC:UITableViewDelegate,UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return arrayList.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = arrayList[section]
        return section.items?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.jk.dequeueReusableCell(cellType: UITableViewCell.self, cellForRowAt: indexPath)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        let section = arrayList[indexPath.section]
        if let item:LKBaseItem = section.items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.detailTextLabel?.text = item.subTitle
        } else {
            cell.textLabel?.text = ""
            cell.detailTextLabel?.text = ""
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = arrayList[indexPath.section]
        if let item:LKBaseItem = section.items?[indexPath.row] {
            if item.jumpType == .lkFunc {
                callMethod(withName: item.jumpValue ?? "")
            }
            
            if item.jumpType == .lkVC {
                callViewController(withName: item.jumpValue ?? "")
            }
        }
    }
}

extension UIViewController {
    
    /// 添加UIViewController 方法调用
    /// - Parameter selectorString: 方法名
    func callMethod(withName selectorString:String) -> Void {
        if selectorString.isEmpty{
            return
        }
        let aselector = Selector(selectorString)
        if responds(to: aselector){
            perform(aselector)
        }else{
            assert(false,"该方法不存在,检查确认后调用")
        }
    }
    
    /// 添加UIViewController 视图控制器调用
    /// - Parameter selectorString: 方法名
    func callViewController(withName viewControllerName:String) -> Void {
        if viewControllerName.isEmpty{
            return
        }
        if let myClass = NSClassFromString(viewControllerName) as? UIViewController.Type {
            let vc = myClass.init()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            assert(false,"该方法不存在,检查确认后调用")
        }
    }
}
