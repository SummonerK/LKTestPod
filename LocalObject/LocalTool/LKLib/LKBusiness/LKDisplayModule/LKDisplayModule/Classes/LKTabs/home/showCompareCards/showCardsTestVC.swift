//
//  showCardsTestVC.swift
//  LKDisplayModule
//
//  Created by lofi on 2024/12/10.
//

import UIKit
import SnapKit

fileprivate let cellHeight: CGFloat = 122
fileprivate let cellWidth: CGFloat = 351

class CustomLayout: UICollectionViewFlowLayout {
    
    var attMuArray = Array<UICollectionViewLayoutAttributes>()
    var shouldExpandCellIndex: Int = 0 // 用于标记是否要扩展单元格
    
    override func prepare() {
        super.prepare()
        // 在此处设置自定义属性
    }
 
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // 根据需要决定是否重新计算布局
        return true
    }
    
    //rect范围下所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attrArray: [UICollectionViewLayoutAttributes] = []
            let itemCount = self.collectionView!.numberOfItems(inSection: 0)
            for i in 0..<itemCount {
                let attr = self.layoutAttributesForItem(at: IndexPath(item: i, section: 0))!
                attrArray.append(attr)
                attMuArray.append(attr)
            }
            return attrArray
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let itemCount = self.collectionView!.numberOfItems(inSection: 0)
//        var fixItemY: CGFloat = CGFloat(indexPath.row) * 22
//        var fixItemY: CGFloat = CGFloat(indexPath.row*(indexPath.row + 1)/2) * 10 ///三角形数序列。
//        var fixItemY: CGFloat = CGFloat(indexPath.row*0) + CGFloat(indexPath.row * (indexPath.row + 1)) * CGFloat(35)/CGFloat(itemCount+1) ///等差数列
//        var fixItemY: CGFloat = CGFloat(indexPath.row) * CGFloat(20 - 2*itemCount) + CGFloat(indexPath.row * (indexPath.row + 1)) * 2
//        if indexPath.item > shouldExpandCellIndex {
//            fixItemY = fixItemY + cellHeight + 10
//        }
        let sumValue = toolSeriesOffSet(indexPath.row)
        let fixItemY: CGFloat = CGFloat(indexPath.row) * CGFloat(15 - 2*itemCount) + 15*sumValue
//        let fixItemY: CGFloat = CGFloat(indexPath.row) * CGFloat(10 - 1*itemCount) + 30*sineValue
//        let fixItemY: CGFloat = CGFloat(indexPath.row) * CGFloat(20 - 2*itemCount) + CGFloat(indexPath.row * (indexPath.row + 1)) * (2)
        let fixItemWidth: CGFloat = cellWidth
        attributes.frame = CGRect(x: (IBScreenW-fixItemWidth)/2, y: fixItemY, width: fixItemWidth, height: cellHeight)
        let changeValue = 1.0 - CGFloat(itemCount - indexPath.row - 1) * (0.02)
        attributes.transform3D = CATransform3DMakeScale(changeValue, changeValue, 1) // 将layer 缩放
        attributes.zIndex = itemCount + indexPath.item
        
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        guard let attributes = self.attMuArray.last else { return .zero }
        return CGSize(width: IBScreenW, height: CGRectGetMaxY(attributes.frame))
    }
    
    private func toolSeriesOffSet(_ index: Int) -> CGFloat {
        let angleInDegree: CGFloat = 18
        let angleInRadian = angleInDegree * Double.pi / 180.0
        var sumValue: CGFloat = 0
        for itemIndex in 0..<index  {
            let sineValue = sin(angleInRadian*Double(itemIndex))
            sumValue += sineValue
        }
        return sumValue
    }
    
}

fileprivate let cardMaxNum = 5

@objc public class showCardsTestVC: UIViewController {
    
    class XMStrangeMatchPopWindow: UIWindow {
        //默认背景点击不穿透
        public var windowHitType: Int = 1020 {
            didSet {
                windowLevel = UIWindow.Level(CGFloat(windowHitType))
            }
        }
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            let view = super.hitTest(point, with: event)
            if (view == self && windowHitType == 1010){
                return nil
            }
            return view
        }
    }
    
    var arrayCards: Array<cardModel> = Array()
    var indexPath: IndexPath?
    var beginPoint: CGPoint = .zero
    var beginFrameCenter: CGPoint = .zero
    var isDeleting: Bool = false
    
    lazy var viewbutton:UIButton = {
        let button = UIButton.init(type: .custom)
        button.addTarget(self, action: #selector(goComplareClick(_:)), for: .touchUpInside)
        button.backgroundColor = .lkRandomColor(1)
        return button
    }()
    
    lazy var layoutKK: CustomLayout = {
        let layout = CustomLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
//        layout.shouldExpandCellIndex = itemCount - 1
        return layout
    }()
    
    lazy var collectionViewContent: UICollectionView = {
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: layoutKK)
        view.jk.register(cellClass: LKCompareCardCCell.self)
        view.isPrefetchingEnabled = true
        view.isPagingEnabled = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        view.contentMode = .scaleToFill
        view.backgroundColor = .clear
        view.dataSource = self
        view.delegate = self

        return view
    }()
    
    lazy var dragingItem: LKCompareCardCCell = {
        let CellW:CGFloat = cellWidth
        let CellH:CGFloat = cellHeight
        let cell: LKCompareCardCCell = LKCompareCardCCell.init(frame: CGRect(x: 0, y: 0, width: CellW, height: CellH))
        cell.isHidden = true
        return cell
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lkRandomColor(1)
        
        setupViews()
        
        mockListData()
        
        collectionViewContent.reloadData()
        
//        DispatchQueue.jk.asyncDelay(10, {
//        }, { [weak self] in
//            guard let self = self else { return }
//            addNewCard()
//            let topIndex = arrayCards.count - 1
//            collectionViewContent.insertItems(at: [IndexPath(row: topIndex, section: 0)])
//        })
        
    }
    
    func mockListData() {
        let cardMode1: cardModel = cardModel()
        cardMode1.timeDown = 10
        let cardMode2: cardModel = cardModel()
        cardMode2.timeDown = 10
        let cardMode3: cardModel = cardModel()
        cardMode3.timeDown = 10
        let cardMode4: cardModel = cardModel()
        cardMode4.timeDown = 10
        arrayCards.append(cardMode1)
        arrayCards.append(cardMode2)
        arrayCards.append(cardMode3)
        arrayCards.append(cardMode4)
    }
    
    private func removeFirst() {
        arrayCards.removeFirst()
    }
    
    private func addNewCard() {
        drageCardReset()
        let cardMode1: cardModel = cardModel()
        cardMode1.timeDown = 20
        arrayCards.append(cardMode1)
    }
    
    func setupViews() -> Void {
        view.addSubview(viewbutton)
        view.addSubview(collectionViewContent)
        
        collectionViewContent.snp.makeConstraints { make in
            make.top.equalTo(120)
            make.left.right.equalTo(0)
            make.height.equalTo(202)
        }
        
        viewbutton.snp.makeConstraints { make in
            make.bottom.equalTo(-49)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(49)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        collectionViewContent.addGestureRecognizer(panGesture)
        view.addSubview(dragingItem)
    }
 
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let point = gesture.location(in: collectionViewContent)
        switch gesture.state {
        case UIGestureRecognizer.State.began:
                dragBegan(point: point)
            break
        case UIGestureRecognizer.State.changed:
                drageChanged(point: point)
            break
        case UIGestureRecognizer.State.ended:
                drageEnded(point: point)
            break
        case UIGestureRecognizer.State.cancelled:
                drageEnded(point: point)
            break
            default: break
        }
    }
    
    /// 拖拽编辑-复位
    private func drageCardReset() {
        guard let indexPath = indexPath else { return }
        let endCell = collectionViewContent.cellForItem(at: indexPath) as? LKCompareCardCCell
        dragingItem.transform = CGAffineTransform.identity
        dragingItem.isHidden = true
        endCell?.isHidden = false
        dragingItem.removeTimer()
        self.indexPath = nil
    }
    
    //MARK: - 开始
    private func dragBegan(point: CGPoint) {
        let beginIndexPath = collectionViewContent.indexPathForItem(at: point)
        guard let beginIndexPath = beginIndexPath else { return }
        if beginIndexPath.row < arrayCards.count-1 {
            return
        }
        indexPath = beginIndexPath
        guard let indexPath = indexPath else { return }
        beginPoint = point
        let item = collectionViewContent.cellForItem(at: indexPath) as? LKCompareCardCCell
        let rect = view.convert((item?.bounds)!, from: item)
        dragingItem.frame = rect
        item?.isHidden = true
        dragingItem.isHidden = false
        dragingItem.cardData = item?.cardData
        dragingItem.beginTimer()
        beginFrameCenter = CGPointMake(rect.origin.x + 120, rect.origin.y + cellHeight/2)
//        beginFrameCenter = item?.center ?? .zero
//        dragingItem.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
    //MARK: - 过程
    private func drageChanged(point: CGPoint) {
        dragingItem.center.y = (beginFrameCenter.y) + (point.y - beginPoint.y)
    }
    
    //MARK: - 结束
    private func drageEnded(point: CGPoint) {
        guard let indexPath = indexPath else { return }
        let rectDraging = view.convert(self.dragingItem.bounds, from: self.dragingItem)
        let endCell = collectionViewContent.cellForItem(at: indexPath) as? LKCompareCardCCell
        if rectDraging.origin.y <= 40 {
            // 优先移除倒计时，避免编辑Cell触发删除逻辑，导致Index问题
            endCell?.removeTimer()
            dragingItem.removeTimer()
            print("可以移除了")
            UIView.animate(withDuration: 0.25, animations: {
                self.dragingItem.frame = CGRect(x: (IBScreenW-cellWidth)/2, y: -cellHeight, width: cellWidth, height: cellHeight)
                self.deleteItemFromTop()
            }, completion: { (finish) -> () in
                self.dragingItem.transform = CGAffineTransform.identity
                self.dragingItem.isHidden = true
                self.indexPath = nil
            })
            return
        }
        
        let rect = view.convert((endCell?.bounds)!, from: endCell)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.dragingItem.frame = rect
        }, completion: { (finish) -> () in
            self.dragingItem.transform = CGAffineTransform.identity
            self.dragingItem.isHidden = true
            endCell?.isHidden = false
            self.dragingItem.removeTimer()
            self.indexPath = nil
        })
    }

    @objc private func goComplareClick(_ btn: UIButton) -> Void {
        // 新增逻辑
//        itemCount += 1
//        collectionViewContent.insertItems(at: [IndexPath(row: self.itemCount-1, section: 0)])
//        self.collectionViewContent.collectionViewLayout.invalidateLayout()
//        self.collectionViewContent.layoutIfNeeded()
//        collectionViewContent.moveItem(at: indexZero, to: indexTop)
        
        if arrayCards.count < cardMaxNum {
            // 新增逻辑
            addNewCard()
            let topIndex = arrayCards.count - 1
            collectionViewContent.insertItems(at: [IndexPath(row: topIndex, section: 0)])
        } else {
            addNewCard()
            removeFirst()
            let topIndex = arrayCards.count - 1
            let indexZero = IndexPath(row: 0, section: 0)
            let indexTop = IndexPath(row: topIndex, section: 0)
            // 替换逻辑
            collectionViewContent.performBatchUpdates({
                collectionViewContent.deleteItems(at: [indexZero])
                collectionViewContent.insertItems(at: [indexTop])
            }, completion: { (finished) in
            })
        }
    }
    
    private func deleteItemFromTop() {
        if arrayCards.count >= 0 {
            arrayCards.removeLast()
            collectionViewContent.deleteItems(at: [IndexPath(row: arrayCards.count, section: 0)])
//            UIView.animate(withDuration: 0.4) {
//                self.collectionViewContent.collectionViewLayout.invalidateLayout()
//                self.collectionViewContent.layoutIfNeeded()
//            }
//            collectionViewContent.reloadData()
//            self.collectionViewContent.collectionViewLayout.invalidateLayout()
//            self.collectionViewContent.layoutIfNeeded()
//            collectionViewContent.performBatchUpdates({
//                collectionViewContent.deleteItems(at: [IndexPath(row: itemCount, section: 0)])
//            }, completion: { (finished) in
////                self.collectionViewContent.reloadData()
////                self.collectionViewContent.collectionViewLayout.invalidateLayout()
////                self.collectionViewContent.layoutIfNeeded()
//            })
        }
    }
    
    private func openCellIn(_ atIndex: Int) {
        
        layoutKK.shouldExpandCellIndex = atIndex
        
        UIView.animate(withDuration: 0.4) {
            self.collectionViewContent.collectionViewLayout.invalidateLayout()
            self.collectionViewContent.layoutIfNeeded()
        }
    }
    
    private func deleteCell(_ index: Int) {
        drageCardReset()
        arrayCards.remove(at: index)
        collectionViewContent.deleteItems(at: [IndexPath(row: index, section: 0)])
        // mark：倒计时涉及 自动删除和新增需要解决
        //      删除/删除/删除
        //      删除/删除/新增
        //      删除/新增/新增
        //      新增/新增/新增
        //
//        collectionViewContent.performBatchUpdates({ [weak self] in
//            guard let self = self else { return }
//            arrayCards.remove(at: index)
//            collectionViewContent.deleteItems(at: [IndexPath(row: index, section: 0)])
//        }, completion: { [weak self] (finished) in
//            guard let self = self else { return }
//        })
//        let model = arrayCards[index]
//        print(model.timeOutFlag ? "标识删除" : "未标识删除")
    }
}

extension showCardsTestVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.cellForItem(at: indexPath) as? LKCompareCardCCell
//        
//        var height: CGFloat = 300
//        if cell?.isExpanded == true {
//            height = 500
//        }
//        
//        return CGSize(width: 240, height: height)
//    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCards.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.jk.dequeueReusableCell(cellType: LKCompareCardCCell.self, cellForRowAt: indexPath)
        cell.isHidden = false
        cell.cardData = arrayCards[indexPath.row]
        cell.beginTimer()
        cell.matchNumZero = { [weak self] model in
            guard let self = self else { return }
            guard let model = model else { return }
            if let index = arrayCards.firstIndex(model) {
                print("delete targetIndex = \(index)")
                deleteCell(index)
            }
//            deleteCell(cell.cellIndex)
        }
//        let changeValue = CGFloat(itemCount - indexPath.row - 1) * (-7 * .pi / 180.0)
//        cell.contentView.layer.transform = CATransform3DMakeRotation(changeValue, 0, 1, 0) // 沿某轴旋转
//        let changeValue = CGFloat(itemCount - indexPath.row - 1) * (-5)
//        cell.layer.transform = CATransform3DMakeTranslation(0, 0, changeValue) // 将layer在Z轴向前（屏幕内）平移5个单位
//        let changeValue = 1.0 - CGFloat(itemCount - indexPath.row - 1) * (0.02)
//        cell.layer.transform = CATransform3DMakeScale(changeValue, changeValue, 1) // 将layer 缩放
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        openCellIn(indexPath.row)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.contentView.layer.transform = CATransform3DIdentity
//        let changeValue = CGFloat(itemCount - indexPath.row - 1) * (-7 * .pi / 180.0)
//        cell.contentView.layer.transform = CATransform3DMakeRotation(changeValue, 0, 1, 0) // 沿某轴旋转
    }
    
}

