//
//  LKCompareCardCCell.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/12/10.
//

import UIKit

import SnapKit

class cardModel: NSObject {
    var beginTime: Date?
    var timeDown: Int = 15
    var timeOutFlag: Bool = false
}

class LKCompareCardCCell: UICollectionViewCell {
    
    var isExpanded: Bool = false
    var timer: Timer?
    var beginDate: Date?
    
    open var matchNumZero:((cardModel?) -> Void)?
    var cardData: cardModel?
    
    lazy var labelTip: UILabel = {
        let label = UILabel()
        label.text = "自动拒绝"
        label.font = UIFont(name: "PingFangSC-Regular", size: 12)
        label.textColor = UIColor(hexString: "#999999")
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    lazy var imageViewBg: UIImageView = {
        let imageView = UIImageView()
        imageView.image = LKDisplayHelper.image(withName: "bg_match")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        print("LKCompareCardCCell dealloc")
        timer?.invalidate()
        self.timer = nil
    }
    
    private func configView() {
        self.backgroundColor = .clear
//        self.contentView.jk.addCorner(conrners: .allCorners, radius: 20, borderWidth: 4, borderColor: .white)
//        self.contentView.backgroundColor = .lkColor(withHex: "#C6F1D5")
//        self.contentView.backgroundColor = .lkRandomColor(1)
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(imageViewBg)
        imageViewBg.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.contentView.addSubview(labelTip)
        labelTip.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.right.equalTo(-14)
            make.height.equalTo(17)
            make.width.greaterThanOrEqualTo(44)
        }
    }
    
    public func beginTimer(_ withDate:Date = Date()) {
        guard let cardData = cardData else { return }
        var targetDate: Date
        if let cellDate = cardData.beginTime {
            targetDate = cellDate
        } else {
            targetDate = withDate
        }
        let currentDate = Date()
        let endCount = toolTimeSpace(date: targetDate, nowDate: currentDate, timeDown: cardData.timeDown)
        if endCount <= 0 {
            cardData.timeOutFlag = true
            labelTip.text = "自动拒绝"
            return
        }
        cardData.beginTime = targetDate
        self.beginDate = targetDate
        removeTimer()
        timer = Timer.init(timeInterval: 0.1, target: self, selector: #selector(timerFire), userInfo: nil, repeats: true)
        guard let timer = timer else { return }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    public func removeTimer() {
//        print("移除了Timer")
        timer?.invalidate()
        self.timer = nil
    }
    
    @objc func timerFire() {
        guard let cardData = cardData else { return }
        guard let beginDate = beginDate else { return }
        let currentDate = Date()
        let endCount = toolTimeSpace(date: beginDate, nowDate: currentDate, timeDown: cardData.timeDown)
        if endCount <= 0 {
            cardData.timeOutFlag = true
            labelTip.text = "自动拒绝"
            removeTimer()
            matchNumZero?(cardData)
            return
        }
        labelTip.text = "\(endCount)s自动拒绝"
    }
    
    func toolTimeSpace(date: Date,nowDate: Date,timeDown: Int) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: date, to: nowDate)
        let endCount = timeDown - (components.second ?? 0)
        return endCount
    }
}
