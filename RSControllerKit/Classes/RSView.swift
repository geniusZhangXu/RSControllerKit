//
//  RSView.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSView
class RSView: UIView {
    
    /// Description
    /// - Parameter frame: frame description
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
        self.rsAddLayoutConstraintWithSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置View的圆角
    open var rsCornerRadius:CGFloat = 0 {
        
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = rsCornerRadius
        }
    }
    
    /// 设置View的边框颜色
    open var rsBorderColor:UIColor = .red {
        
        didSet{
            self.layer.borderWidth = 1
            self.layer.borderColor = rsBorderColor.cgColor
        }
    }
    
}

extension RSView{
    
    @objc open func rsAddLayoutConstraintWithSubviews() {}
}



