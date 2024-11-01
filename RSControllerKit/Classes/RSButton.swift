//
//  RSButton.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSButton
public class RSButton: UIButton {
    
    /// 根据图片的名称-初始化按钮
    /// - Parameter imageName: imageName description
    public convenience init(_ imageName:String) {
        
        self.init(type: .custom)
        self.setImage(UIImage(named: imageName), for: .normal)
    }
    
    /// 设置圆角
    public var rsCornerRadius:CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = rsCornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    /// BoldFontSize
    public var rsBoldFont:CGFloat = 0.0 {
        didSet{
            self.titleLabel?.font = UIFont.boldSystemFont(ofSize: rsBoldFont)
        }
    }
    
    /// SystemFontSize
    public var rsSystemFont:CGFloat = 0.0 {
        didSet{
            self.titleLabel?.font = UIFont.systemFont(ofSize: rsSystemFont)
        }
    }
    
    /// 边框按钮颜色 - 默认边框宽度为1
    public var rsBorderColor:UIColor = .white {
        didSet{
            self.layer.borderWidth = 1
            self.layer.borderColor = rsBorderColor.cgColor
        }
    }
    
    /// 字体按钮颜色
    public var rsTitleColor:UIColor = .white {
        didSet{
            self.setTitleColor(rsTitleColor, for: .normal)
        }
    }
    
}


