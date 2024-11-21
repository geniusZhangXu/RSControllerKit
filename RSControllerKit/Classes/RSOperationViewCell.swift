//
//  RSOperationViewCell.swift
//  MrRisingSun
//
//  Created by Mr.RisingSun on 29.10.24.
//

import UIKit
import Foundation

// MARK: - Extension-UIView
fileprivate extension UIView {
    
    /// 获取View的固定类型的rsSuperView
    /// - Parameter type: type description
    /// - Returns: description
    func rsSuperView<T>(of type: T.Type) -> T? {
        
        return superview as? T ?? superview.flatMap { $0.rsSuperView(of: T.self) }
    }
    
}

// MARK: - - Extension-UICollectionView
struct AssociatedKeys {
    
    static var rsCurrentViewCell:Void?
}

fileprivate extension UICollectionView {
    
    /// 记录一个唯一的Cell,主要作用是在记录开始操作一个Cell之后我们尝试开始操作另一个Cell,我们会关掉前一个Cell的操作动画
    var rsOpeningViewCell: RSOperationViewCell? {
        
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.rsCurrentViewCell) as? RSOperationViewCell
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self,&AssociatedKeys.rsCurrentViewCell, newValue as RSOperationViewCell?,.OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
}

///
/// ===================================================================================================
/// DeleteButtonOperation
public typealias DeleteButtonOperation = (_ sender: UIButton) -> ()

///
// MARK: - RSOperationViewCell
open class RSOperationViewCell: RSCollectionViewCell {
        
    // MARK: - Public
    ///
    /// 自定义一个操作View
    public var rsOperationView: UIView?
    
    /// 删除操作回调
    public var rsDeleteButtonOperation: DeleteButtonOperation?
    
    /// 隐藏操作View的动画
    /// - Parameter isAnimated: isAnimated description
    public func rsHideOperationView(withAnimated isAnimated:Bool) {
        
        UIView.animate(withDuration: isAnimated ? 0.1 : 0, delay: 0,options: .curveEaseOut, animations: {
                       
            self.rsSnapShotView?.center = CGPoint(x: self.frame.width / 2, y: self.rsSnapShotView!.center.y)
        }, completion: { (finished: Bool) in
            
            self.rsSnapShotView?.removeFromSuperview()
            self.rsSnapShotView = nil
            self.rsOperationView?.removeFromSuperview()
        })
    }
    
    // MARK: - Private
    /// 内部需要rsSnapShotView
    fileprivate var rsSnapShotView:UIView?
    /// 滑动手势
    private var rsPanGesture:UIPanGestureRecognizer!
    
    /// Description
    /// - Parameter frame: frame description
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        /// 添加手势
        self.configureGestureRecognizer()
    }
    
    /// Description
    /// - Parameter aDecoder: aDecoder description
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /// 添加手势
        self.configureGestureRecognizer()
    }
    
    /// 重写prepareForReuse-准备复用前的方法
    open override func prepareForReuse() {
        
        super.prepareForReuse()
        self.rsSnapShotView?.removeFromSuperview()
        self.rsSnapShotView = nil
        self.rsOperationView?.removeFromSuperview()
    }
    
    /// 重写layoutSubviews
    open override func layoutSubviews() {
        
        super.layoutSubviews()
        guard let rsOperationView = rsOperationView else { return }
        rsOperationView.frame = CGRect(origin: CGPoint(x: self.frame.width - rsOperationView.frame.width, y: 0) , size: rsOperationView.frame.size)
    }

}

// MARK: - UIGestureRecognizerDelegate
extension RSOperationViewCell:UIGestureRecognizerDelegate{
    
    /// 添加手势
    private func configureGestureRecognizer() {
        
        self.rsPanGesture = UIPanGestureRecognizer(target: self, action: #selector(rsPanGestureRecognizerAction(rsPanGestureRecognizer:)))
        self.rsPanGesture.delegate = self
        self.addGestureRecognizer(rsPanGesture)
    }
        
    /// Description
    /// - Parameter gestureRecognizer: gestureRecognizer description
    /// - Returns: description
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        if gestureRecognizer.isMember(of: UIPanGestureRecognizer.self) {
            
            let gesture:UIPanGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
            let velocity = gesture.velocity(in: self)
            if abs(velocity.x) > abs(velocity.y) {
                return true
            }
        }
        return false
    }
    
    /// Description
    /// - Parameters:
    ///   - gestureRecognizer: gestureRecognizer description
    ///   - otherGestureRecognizer: otherGestureRecognizer description
    /// - Returns: description
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return otherGestureRecognizer != self.rsSuperView(of: UICollectionView.self)
    }
    
    /// 手势响应事件
    /// - Parameter rsPanGestureRecognizer: rsPanGestureRecognizer description
    @objc private func rsPanGestureRecognizerAction(rsPanGestureRecognizer: UIPanGestureRecognizer) {
        
        switch rsPanGestureRecognizer.state {
        case .began:
            if  self.rsOperationView == nil {
                self.createDefaultOperationView()
            }
            if  self.rsSnapShotView == nil {
                self.rsSnapShotView = self.snapshotView(afterScreenUpdates: false)
                if  self.rsSnapShotView?.backgroundColor == UIColor.clear || self.rsSnapShotView?.backgroundColor == nil {
                    self.rsSnapShotView?.backgroundColor = UIColor.white
                }
            }
            guard let rsSnapShotView = self.rsSnapShotView else { return }
            self.closeOtherOpeningCell()
            self.addSubview(self.rsOperationView!)
            self.addSubview(rsSnapShotView)
        case .changed:
            let translationPoint = rsPanGestureRecognizer.translation(in: self)
            var centerPoint = CGPoint(x: 0, y: self.rsSnapShotView!.center.y)
            centerPoint.x = min( self.frame.width / 2, max(self.rsSnapShotView!.center.x + translationPoint.x, self.frame.width/2 - self.rsOperationView!.frame.width))
            rsPanGestureRecognizer.setTranslation(CGPoint.zero, in: self)
            self.rsSnapShotView!.center = centerPoint
        case .ended,
             .cancelled:
            let velocity = rsPanGestureRecognizer.velocity(in: self)
            if  bigThenOperationViewHalfWidth() || shouldShowWithOperationView(forVelocity: velocity) {
                showRevealView(withAnimated: true)
            }
            if lessThenOperationViewHalfWidth() || shouldHideWithOperationView(forVelocity: velocity) {
                rsHideOperationView(withAnimated: true)
            }
        default: break
        }
    }
    
    /// Description
    /// - Parameter velocity: velocity description
    /// - Returns: description
    private func shouldHideWithOperationView(forVelocity velocity: CGPoint) -> Bool {
        
        guard let rsOperationView = self.rsOperationView else { return false }
        return abs(velocity.x) > rsOperationView.frame.width / 2 && velocity.x > 0
    }
    
    /// Description
    /// - Parameter velocity: velocity description
    /// - Returns: description
    private func shouldShowWithOperationView(forVelocity velocity: CGPoint) -> Bool {
        
        guard let rsOperationView = self.rsOperationView else { return false }
        return abs(velocity.x) > rsOperationView.frame.width / 2 && velocity.x < 0;
    }
    
    /// Description
    /// - Returns: description
    private func bigThenOperationViewHalfWidth() -> Bool {
        
        guard let rsOperationView = self.rsOperationView, let rsSnapShotView = self.rsSnapShotView else { return false }
        return abs(rsSnapShotView.frame.width) >= rsOperationView.frame.width / 2
    }
    
    /// Description
    /// - Returns: description
    private func lessThenOperationViewHalfWidth() -> Bool {
        
        guard let rsOperationView = self.rsOperationView,let rsSnapShotView = self.rsSnapShotView else { return false }
        return abs(rsSnapShotView.frame.width) < rsOperationView.frame.width / 2
    }
    
    /// 关闭其他操作的Cell
    private func closeOtherOpeningCell() {
        
        guard let superCollectionView = self.rsSuperView(of: UICollectionView.self) else { return }
        /// 重点判断：rsOpeningViewCell
        if superCollectionView.rsOpeningViewCell != self {
            if  superCollectionView.rsOpeningViewCell != nil {
                superCollectionView.rsOpeningViewCell!.rsHideOperationView(withAnimated: true)
            }
            superCollectionView.rsOpeningViewCell = self
        }
    }
    
    /// 展示操作Viwe的动画
    /// - Parameter isAnimated: isAnimated description
    private func showRevealView(withAnimated isAnimated:Bool) {
        
        UIView.animate(withDuration: isAnimated ? 0.1 : 0 , delay: 0, options: .curveEaseOut, animations: {
                        
            self.rsSnapShotView?.center = CGPoint(x: self.frame.width / 2 - self.rsOperationView!.frame.width , y: self.rsSnapShotView!.center.y)
        }, completion: { (finished: Bool) in })
    }
    
}

extension RSOperationViewCell {
    
    /// 创建一个操作View-默认删除
    private func createDefaultOperationView() {
        
        let deleteButton = UIButton(frame: CGRect(x: self.bounds.height - 60, y: 0, width: 60, height: self.bounds.height))
        deleteButton.backgroundColor = UIColor.init(red: 255/255.0, green: 58/255.0, blue: 58/255.0, alpha: 1)
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(UIColor.white, for: .normal)
        deleteButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        deleteButton.addTarget(self, action: #selector(deleteButtonClickEvent(sender:)), for: .touchUpInside)
        self.rsOperationView = deleteButton
    }
    
    /// 删除点击事件
    /// - Parameter sender: sender description
    @objc private func deleteButtonClickEvent(sender: UIButton) {
        
        self.rsHideOperationView(withAnimated: true)
        self.rsDeleteButtonOperation?(sender)
    }
    
}
