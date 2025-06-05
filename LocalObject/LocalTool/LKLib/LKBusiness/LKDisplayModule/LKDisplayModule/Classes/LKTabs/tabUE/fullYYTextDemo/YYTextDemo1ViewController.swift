//
//  YYTextDemo1ViewController.swift
//  LKDisplayModule
//
//  Created by lofi on 2025/4/12.
//

import UIKit
import LKUtils
import YYText

@objc public class YYTextDemo1ViewController: UIViewController {
    private let maxLength = 100
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewLayouts()
        setupViewConfigs()
    }
    
    
    private func setupViews () {
        view.addSubview(textViewTopic)
    }
    
    private func setupViewLayouts () {
        textViewTopic.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(46)
            make.top.equalTo(40)
            make.height.equalTo(160)
        }
    }
    
    private func setupViewConfigs () {
        textViewTopic.attributedText = featchRichText()
    }
    
    lazy var textViewTopic: YYTextView = {
        let textView = YYTextView()
        textView.textColor = .black
        textView.textContainerInset = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
        textView.font = .pingFangRegular(14)
        textView.backgroundColor = .clear
        textView.delegate = self
        return textView
    }()

}

extension YYTextDemo1ViewController: YYTextViewDelegate {
    // 限制最大输入字符数
    public func textView(_ textView: YYTextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let textRange = Range(range, in: currentText) else { return false }
        if range.length > 1 {
            print("\(range)")
        }
        let updatedText = currentText.replacingCharacters(in: textRange, with: text)
        return updatedText.count <= maxLength
    }
    
    public func textViewShouldBeginEditing(_ textView: YYTextView) -> Bool {
        return true
    }
    
    public func textViewDidEndEditing(_ textView: YYTextView) {
        
    }
    
    public func textViewDidChange(_ textView: YYTextView) {
        if textView.text.count > maxLength {
            textView.text = String(textView.text.prefix(maxLength))
        }
    }
    
}

extension YYTextDemo1ViewController {
    func featchRichText() -> NSMutableAttributedString? {
        let baseString = "欢迎大家加入三生集团事业部这个大家庭！大家可以来会议大堂交流聊天"
        let attributedString = NSMutableAttributedString(string: baseString)
        if let hightAttributedString = makeHightLightAttributedString(hightString: "会议厅-享脉广州团队") {
            attributedString.append(hightAttributedString)
        }
        let addString1 = NSMutableAttributedString(string: "，没加入社群的可以上官网")
        attributedString.append(addString1)
        if let hightAttributedString = makeHightLightAttributedString(hightString: "三生中国官网") {
            attributedString.append(hightAttributedString)
        }
        let addString2 = NSMutableAttributedString(string: "看一下介绍，大家一起为了事业奋斗！")
        attributedString.append(addString2)
        attributedString.yy_setFont(.pingFangRegular(14), range: attributedString.yy_rangeOfAll())
        return attributedString
    }
    
    private func makeHightLightAttributedString(hightString: String) -> NSMutableAttributedString? {
        if hightString.isEmpty {
            return nil
        }
        let bindString = " \(hightString) "
        let withAttributedString = NSMutableAttributedString(string: bindString)
        
        guard let baseRnage = bindString.range(of: hightString)  else { return nil }
        let highlightRange = NSRange(baseRnage, in: bindString)
        
        let highlight = YYTextHighlight()
        highlight.tapAction = { (containerView, text, range, rect) in
            print("\(text)")
        }
        
        let textBorder = YYTextBorder()
        textBorder.fillColor = .meetingLightWhiteColor
        textBorder.strokeWidth = 0.5
        textBorder.cornerRadius = 4 // 圆角半径
        textBorder.lineJoin = .bevel
        textBorder.insets = UIEdgeInsets.init(top: 1, left: -4, bottom: 1, right: -4)
        // 应用高亮
        withAttributedString.yy_setTextHighlight(highlight, range: highlightRange)
        withAttributedString.yy_setColor(.meetingBlueColor, range: highlightRange)
        withAttributedString.yy_setTextBackgroundBorder(textBorder, range: highlightRange)
        withAttributedString.yy_setTextBinding(YYTextBinding(deleteConfirm: false), range: highlightRange)
        
        return withAttributedString
    }
}
