//
//  RSLabel.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSLabel
public class RSLabel: UILabel {
    
    /// Description
    /// - Parameter frame: frame description
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.isUserInteractionEnabled = true
        self.backgroundColor = .clear
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置圆角
    public var rsCornerRadius:CGFloat = 0 {
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = rsCornerRadius
        }
    }
    
    /// SystemFontSize
    public var rlSystemFont:CGFloat = 0.0 {
        didSet{
            self.font = UIFont.systemFont(ofSize: rlSystemFont)
        }
    }
    
    /// BoldSize
    public var rsBoldFont:CGFloat = 0.0 {
        didSet{
            self.font = UIFont.boldSystemFont(ofSize: rsBoldFont)
        }
    }

    /// Lable设置边框颜色
    public var rsBorderColor:UIColor = .white {
        didSet{
            self.layer.borderWidth = 1
            self.layer.borderColor = rsBorderColor.cgColor
        }
    }
    
}

