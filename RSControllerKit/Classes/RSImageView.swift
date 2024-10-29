//
//  RSImageView.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSImageView
class RSImageView: UIImageView {
    
    /// Description
    /// - Parameter image: image description
    override init(image: UIImage?) {
        super.init(image: image)
        
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = true
    }
    
    /// 根据图片名称便利构造ImageView
    /// - Parameter rsImageName: rsImageName description
    convenience init(rsImageName:String) {
        
        self.init(image: UIImage(named: rsImageName))
    }
    
    /// 根据需要拉伸的图片进行初始化
    /// - Parameters:
    ///   - rsImageName: rsImageName 图片名称
    ///   - rsCapInsets: rsCapInsets 拉伸缩进距离
    convenience init(rsImageName: String,rsCapInsets:UIEdgeInsets) {
        
        let rsImage = UIImage(named: rsImageName)?.resizableImage(withCapInsets: rsCapInsets, resizingMode: UIImage.ResizingMode.stretch)
        self.init(image: rsImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 属性设置
    /// 设置圆角
    open var rsCornerRadius:CGFloat = 0.0 {
        
        didSet{
            
            self.layer.cornerRadius = rsCornerRadius
            self.layer.masksToBounds = true
        }
    }
    
}


