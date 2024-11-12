//
//  RSScrollStackView.swift
//  MrRisingSun
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSScrollStackView
public class RSScrollStackView: RSView {
    
    /// fizzScrollView
    private lazy var rsScrollView: UIScrollView = {
        
        let rsScrollView = UIScrollView()
        rsScrollView.backgroundColor = .clear
        rsScrollView.showsHorizontalScrollIndicator = false
        rsScrollView.translatesAutoresizingMaskIntoConstraints = false
        return rsScrollView
    }()
    
    /// rsStackView
    private lazy var rsStackView: UIStackView = {
        
        let rsStackView = UIStackView()
        rsStackView.spacing = 10
        rsStackView.axis = .vertical
        rsStackView.alignment = .center
        rsStackView.translatesAutoresizingMaskIntoConstraints = false
        return rsStackView
    }()
    
    /// 设置rsStackView的spacing值
    public var rsStackSpacing:CGFloat = 0.0 {
        didSet{
            self.rsStackView.spacing = rsStackSpacing
        }
    }
    
    /// 设置rsStackView的axis属性
    public var rsStackAxis:NSLayoutConstraint.Axis = .vertical {
        didSet{
            self.rsStackView.axis = rsStackAxis
        }
    }
    
    /// 设置rsStackView的alignment属性
    public var rsStackAlignment:UIStackView.Alignment = .center {
        didSet{
            self.rsStackView.alignment = rsStackAlignment
        }
    }
    
}

extension RSScrollStackView{
    
    /// 给UIStackView添加子视图
    /// - Parameter rsSubView: rsSubView description
    public func rsScrollStackAddSubView(_ rsSubView:UIView) {
        
        self.rsStackView.addArrangedSubview(rsSubView)
    }
    
    /// 把View插入到某个Index位置
    /// - Parameters:
    ///   - rsSubView: rsSubView description
    ///   - atIndex: atIndex description
    public func rsScrollStackInsertSubView(_ rsSubView:UIView, atIndex:Int) {
        
        if !self.rsStackView.subviews.contains(rsSubView) {
            self.rsStackView.insertArrangedSubview(rsSubView, at: atIndex)
        }
    }
    
    /// 删除UIStackView的子视图
    /// - Parameter rsSubView: rsSubView description
    public func rsScrollStackRemoveSubView(_ rsSubView:UIView) {
        
        /// 删除之前-判断是否有这个子视图
        if self.rsStackView.subviews.contains(rsSubView) {
            self.rsStackView.removeArrangedSubview(rsSubView)
        }
    }
}

extension RSScrollStackView{
    
    public override func rsAddLayoutConstraintWithSubviews() {
        super.rsAddLayoutConstraintWithSubviews()
        
        self.addSubview(self.rsScrollView)
        NSLayoutConstraint.activate([
           
            self.rsScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.rsScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.rsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.rsScrollView.widthAnchor.constraint(equalToConstant: RSScreenWidth)
        ])
        
        self.rsScrollView.addSubview(self.rsStackView)
        NSLayoutConstraint.activate([
           
            self.rsStackView.widthAnchor.constraint(equalToConstant: RSScreenWidth),
            self.rsStackView.topAnchor.constraint(equalTo: self.rsScrollView.topAnchor),
            self.rsStackView.bottomAnchor.constraint(equalTo: self.rsScrollView.bottomAnchor),
            self.rsStackView.leadingAnchor.constraint(equalTo: self.rsScrollView.leadingAnchor)
        ])
        
    }
    
}
