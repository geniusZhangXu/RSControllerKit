//
//  RSNavigationBarView.swift
//  RSExtension
//
//  Created by 杨张锋 on 29.10.24.
//

import UIKit
import Foundation

/// RSNavigationBarView
class RSNavigationBarView: RSView {
    
    /// 返回按钮
    open lazy var rsReturnButton: RSButton = {
        
        let rsReturnButton = RSButton(type: .custom)
        rsReturnButton.translatesAutoresizingMaskIntoConstraints = false
        return rsReturnButton
    }()
    
    /// 导航的标题
    open lazy var rsTitleLabel: RSLabel = {
        
        let rsTitleLabel  = RSLabel.init(frame: CGRect.zero)
        rsTitleLabel.textAlignment = .center
        rsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return rsTitleLabel
    }()
    
    /// 右边的按钮
    /// 需要定义成变量-后续我们可以直接赋值给它
    open var rsRightButton: RSButton?{
        
        didSet {
            
            if let rightButton = self.rsRightButton {

                rightButton.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(rightButton)
                NSLayoutConstraint.activate([
                
                    rightButton.heightAnchor.constraint(equalToConstant: 44),
                    rightButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                    rightButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
                ])
            }
        }
    }
}

extension RSNavigationBarView{
    
    /// 给子视图添加约束
    override func rsAddLayoutConstraintWithSubviews() {
        super.rsAddLayoutConstraintWithSubviews()
        
        self.addSubview(self.rsReturnButton)
        self.addSubview(self.rsTitleLabel)
        
        NSLayoutConstraint.activate([
          
            self.rsReturnButton.widthAnchor.constraint(equalToConstant: 56.0),
            self.rsReturnButton.heightAnchor.constraint(equalToConstant: 44.0),
            self.rsReturnButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.rsReturnButton.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
          
            self.rsTitleLabel.heightAnchor.constraint(equalToConstant: 44.0),
            self.rsTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.rsTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 68),
            self.rsTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -68)
        ])
    }
    
}

