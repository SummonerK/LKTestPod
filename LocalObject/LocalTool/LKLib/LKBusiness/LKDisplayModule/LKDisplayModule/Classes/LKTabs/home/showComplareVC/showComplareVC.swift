//
//  showComplareVC.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/11/18.
//

import UIKit
import SnapKit

let IBScreenW = UIScreen.main.bounds.size.width
let IBScreenH = UIScreen.main.bounds.size.height

@objc public class showComplareVC: UIViewController {
    let animationBeginDuration:CFTimeInterval = 0.16
    let animationBounceDuration: CFTimeInterval = 0.2
    let animationEndDuration: CFTimeInterval = 0.16
    
    let offSetTopArea:CGFloat = 200
    let headViewSize:CGFloat = 78
    let bounceSpace:CGFloat = 16
    let endSpace:CGFloat = 10
    
    let complareShowEdgeInset:UIEdgeInsets = {
        return UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 64)
    }()
    
    lazy var viewUser:UIView = {
        let view = UIView()
        view.frame = CGRect(x: complareShowEdgeInset.left, y: offSetTopArea, width: headViewSize, height: headViewSize)
        view.jk.addCorner(conrners: UIRectCorner.allCorners, radius: headViewSize/2, borderWidth: 2, borderColor: .hexStringColor(hexString: "#FFFFFF"))
        view.backgroundColor = .lkRandomColor(1)
        view.layer.opacity = 0
        return view
    }()
    
    lazy var viewTarget:UIView = {
        let view = UIView()
        view.frame = CGRect(x: IBScreenW - complareShowEdgeInset.right - headViewSize, y: offSetTopArea, width: headViewSize, height: headViewSize)
        view.jk.addCorner(conrners: UIRectCorner.allCorners, radius: headViewSize/2, borderWidth: 2, borderColor: .hexStringColor(hexString: "#FFFFFF"))
        view.backgroundColor = .lkRandomColor(1)
        view.layer.opacity = 0
        return view
    }()
    
    lazy var viewUserBase:UIView = {
        let view = UIView()
        view.frame = CGRect(x: complareShowEdgeInset.left, y: offSetTopArea, width: headViewSize, height: headViewSize)
        view.jk.addCorner(conrners: UIRectCorner.allCorners, radius: 39)
        view.backgroundColor = .lkRandomColor(0.1)
        return view
    }()
    
    lazy var viewTargetBase:UIView = {
        let view = UIView()
        view.frame = CGRect(x: IBScreenW - complareShowEdgeInset.right - headViewSize, y: offSetTopArea, width: headViewSize, height: headViewSize)
        view.jk.addCorner(conrners: UIRectCorner.allCorners, radius: 39)
        view.backgroundColor = .lkRandomColor(0.1)
        return view
    }()
    
    lazy var viewbutton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(goComplareClick(_:)), for: .touchUpInside)
        button.backgroundColor = .lkRandomColor(1)
        return button
    }()
    
    lazy var viewbuttonReset:UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(getResetClick(_:)), for: .touchUpInside)
        button.setTitle("归位", for: .normal)
        button.backgroundColor = .lkRandomColor(1)
        return button
    }()
    
    lazy var viewbuttonLabel:UILabel = {
        let view = UILabel()
        view.backgroundColor = .lkRandomColor(1)
        return view
    }()
    
    lazy var SVGPlayView:matchLikeView = {
        let likeView = matchLikeView(frame: .zero)
        likeView.backgroundColor = .lkRandomColor(0.1)
        return likeView
    }()
    
    lazy var controlView:UIView = {
        let controlView = UIView(frame: CGRect(x: 50-4, y: 500-4, width: 8, height: 8))
        controlView.layer.cornerRadius = 4
        controlView.backgroundColor = .lkRandomColor(0.5)
        return controlView
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor(.lkRandomColor(0.3))

        setupViews()
        
//        drawQuadCurve()
        
        drawQuadCurveLayer()
    }
    
    func setupViews() -> Void {
        view.addSubview(viewUserBase)
        view.addSubview(viewTargetBase)
        view.addSubview(SVGPlayView)
        view.addSubview(viewUser)
        view.addSubview(viewTarget)
        view.addSubview(viewbutton)
        view.addSubview(viewbuttonReset)
        view.addSubview(controlView)
        
        SVGPlayView.snp.makeConstraints { make in
            make.top.equalTo(offSetTopArea-66)
//            make.left.equalTo(complareShowEdgeInset.left)
//            make.right.equalTo(-complareShowEdgeInset.right)
            make.centerX.equalToSuperview()
            make.width.equalTo(308)
            make.height.equalTo(164)
        }
        
        viewbutton.snp.makeConstraints { make in
            make.bottom.equalTo(-49)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(49)
        }
        
        viewbuttonReset.snp.makeConstraints { make in
            make.bottom.equalTo(-108)
            make.left.equalTo(20)
            make.size.equalTo(CGSize(width: 60, height: 49))
        }
    }
    
    func drawQuadCurve() -> Void {
        
///         ComplexShapeView: UIView {
//        override func draw(_ rect: CGRect) {
        let controlPoint = CGPoint(x: 150, y: 400)
        let controlView = UIView(frame: CGRect(x: Int(controlPoint.x-1), y: Int(controlPoint.y-1), width: 2, height: 2))
        controlView.layer.cornerRadius = 1
        controlView.backgroundColor = .lkRandomColor(0.5)
        view.addSubview(controlView)
        // 创建一个UIBezierPath实例
        let path = UIBezierPath()
        // 设置曲线的起点
        path.move(to: CGPoint(x: 50, y: 500))
        // 添加二次贝塞尔曲线，传入控制点和终点坐标
        path.addQuadCurve(to: CGPoint(x: 250, y: 500), controlPoint: controlPoint)
        // 设置曲线的描边颜色和宽度
        UIColor.black.setStroke()
        path.lineWidth = 4
//        // 进行描边操作，绘制出曲线
        path.stroke()
    }
    
    func drawQuadCurveLayer() -> Void {
        let controlPoint               = CGPoint(x   : 150, y   : 480)
        let controlView                = UIView(frame : CGRect(x : Int(controlPoint.x-2), y : Int(controlPoint.y-2), width : 4, height : 4))
        controlView.layer.cornerRadius = 2
        controlView.backgroundColor    = .lkRandomColor(0.5)
        view.addSubview(controlView)
        // 创建一个UIBezierPath实例
        let path = UIBezierPath()
        // 设置曲线的起点
        path.move(to: CGPoint(x: 50, y: 500))
        // 添加二次贝塞尔曲线，传入控制点和终点坐标
        path.addQuadCurve(to: CGPoint(x: 250, y: 500), controlPoint: controlPoint)
        // 创建CAShapeLayer实例并设置路径
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath

        // 设置填充颜色为透明（不填充），描边颜色为红色，线宽为2像素
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 1

        // 将CAShapeLayer添加到按钮的图层上
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc private func goComplareClick(_ btn: UIButton) -> Void {
//        showComplareBeginAnimation()
//        showComplareRightAnimation()
//        DispatchQueue.jk.asyncDelay(0.16) {
//        } _: {
//            self.SVGPlayView.svgBeginPlay()
//        }
//        SVGPlayView.svgBeginPlay()
        showBezierPathAnimation()
    }
    
    @objc private func getResetClick(_ btn: UIButton) -> Void {
        viewUser.backgroundColor = .lkRandomColor(1)
        viewTarget.backgroundColor = .lkRandomColor(1)
        viewUser.layer.removeAllAnimations()
        viewTarget.layer.removeAllAnimations()
    }
    
}

// MARK: - 匹配动画
extension showComplareVC {
    private func showComplareBeginAnimation() -> Void {
        let originalPoint: CGPoint = viewUser.center
        //连续动画组
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.fromValue = originalPoint
        animation.toValue = CGPoint(x: (IBScreenW-headViewSize)/2 + 5, y: originalPoint.y)
        animation.duration = animationBeginDuration
        animation.fillMode = CAMediaTimingFillMode.forwards;
        animation.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animation.beginTime = 0
        
        let animationB = CABasicAnimation.init(keyPath: "position")
        animationB.fromValue = CGPoint(x: (IBScreenW-headViewSize)/2 + 5, y: originalPoint.y)
        animationB.toValue = CGPoint(x: (IBScreenW-headViewSize)/2 - 11, y: originalPoint.y)
        animationB.duration = animationBounceDuration
        animationB.fillMode = CAMediaTimingFillMode.forwards;
        animationB.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationB.beginTime = animationBeginDuration

        let animationC = CABasicAnimation.init(keyPath: "position")
        animationC.fromValue = CGPoint(x: (IBScreenW-headViewSize)/2 - 11, y: originalPoint.y)
        animationC.toValue = CGPoint(x: (IBScreenW-headViewSize)/2 + 5, y: originalPoint.y)
        animationC.duration = animationEndDuration
        animationC.fillMode = CAMediaTimingFillMode.forwards;
        animationC.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationC.beginTime = animationBeginDuration + animationBounceDuration
        
        let animationAlpha = CABasicAnimation(keyPath: "opacity")
        animationAlpha.fromValue = 0.0
        animationAlpha.toValue = 1.0
        animationAlpha.duration = animationBeginDuration
        animationAlpha.fillMode = CAMediaTimingFillMode.forwards;
        animationAlpha.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationAlpha.beginTime = 0

        //组合动画
        let animationGroup:CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [animation,animationAlpha,animationB,animationC]
        animationGroup.duration = animationBeginDuration+animationBounceDuration+animationEndDuration
        animationGroup.fillMode = CAMediaTimingFillMode.both;
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

        viewUser.layer.add(animationGroup, forKey: nil)
    }
    
    private func showComplareRightAnimation() -> Void {
        let originalPoint: CGPoint = viewTarget.center
        //连续动画组
        let animation = CABasicAnimation.init(keyPath: "position")
        animation.fromValue = originalPoint
        animation.toValue = CGPoint(x: (IBScreenW+headViewSize)/2 - 5, y: originalPoint.y)
        animation.duration = animationBeginDuration
        animation.fillMode = CAMediaTimingFillMode.forwards;
        animation.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animation.beginTime = 0
        
        let animationB = CABasicAnimation.init(keyPath: "position")
        animationB.fromValue = CGPoint(x: (IBScreenW+headViewSize)/2 - 5, y: originalPoint.y)
        animationB.toValue = CGPoint(x: (IBScreenW+headViewSize)/2 + 11, y: originalPoint.y)
        animationB.duration = animationBounceDuration
        animationB.fillMode = CAMediaTimingFillMode.forwards;
        animationB.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationB.beginTime = animationBeginDuration

        let animationC = CABasicAnimation.init(keyPath: "position")
        animationC.fromValue = CGPoint(x: (IBScreenW+headViewSize)/2 + 11, y: originalPoint.y)
        animationC.toValue = CGPoint(x: (IBScreenW+headViewSize)/2 - 5, y: originalPoint.y)
        animationC.duration = animationEndDuration
        animationC.fillMode = CAMediaTimingFillMode.forwards;
        animationC.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationC.beginTime = animationBeginDuration + animationBounceDuration
        
        let animationAlpha = CABasicAnimation(keyPath: "opacity")
        animationAlpha.fromValue = 0.0
        animationAlpha.toValue = 1.0
        animationAlpha.duration = animationBeginDuration
        animationAlpha.fillMode = CAMediaTimingFillMode.forwards;
        animationAlpha.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animationAlpha.beginTime = 0

        //组合动画
        let animationGroup:CAAnimationGroup = CAAnimationGroup()
        animationGroup.animations = [animation,animationAlpha,animationB,animationC]
        animationGroup.duration = animationBeginDuration+animationBounceDuration+animationEndDuration
        animationGroup.fillMode = CAMediaTimingFillMode.both;
        animationGroup.isRemovedOnCompletion = false
        animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)

        viewTarget.layer.add(animationGroup, forKey: nil)
    }
    
    func showBezierPathAnimation() -> Void {
        let controlPoint = CGPoint(x: 150, y: 480)
        // 创建一个UIBezierPath实例
        let path = UIBezierPath()
        // 设置曲线的起点
        path.move(to: CGPoint(x: 50, y: 500))
        // 添加二次贝塞尔曲线，传入控制点和终点坐标
        path.addQuadCurve(to: CGPoint(x: 250, y: 500), controlPoint: controlPoint)
        
        let positionAnimation = CAKeyframeAnimation(keyPath: "position")
        positionAnimation.path = path.cgPath
        positionAnimation.duration = 1
        positionAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnimation]
        groupAnimation.duration = 1
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false

        controlView.layer.add(groupAnimation, forKey: "sendFlowerAnimation")
    }
    
}
