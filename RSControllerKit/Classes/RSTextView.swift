//
//  RSTextView.swift
//  MrRisingSun
//
//  Created by Mr.RisingSun on 7/11/2024.
//

import UIKit
import Foundation

/// RSTextView
public class RSTextView: RSView {
    
    /// rsPlaceholderLabel
    private lazy var rsPlaceholderLabel: UILabel = {
        
        let rsPlaceholderLabel = UILabel()
        rsPlaceholderLabel.numberOfLines = 0
        rsPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
        rsPlaceholderLabel.font = UIFont.systemFont(ofSize: self.rsTextViewTextFont)
        return rsPlaceholderLabel
    }()
    
    /// rsTextView
    private lazy var rsTextView: UITextView = {
        
        let rsTextView = UITextView()
        rsTextView.delegate = self
        rsTextView.textColor = .black
        rsTextView.translatesAutoresizingMaskIntoConstraints = false
        rsTextView.font = UIFont.systemFont(ofSize: self.rsTextViewTextFont)
        return rsTextView
    }()
    
    /// 记录TextView的内容【NOTE：该字段不能设置TextView的内容，请设置rsSetTextViewTextString】
    public var rsTextViewTextString = ""
    
    /// 设置TextView的内容
    public var rsSetTextViewTextString:String = "" {
        didSet{
            self.rsTextView.text = rsSetTextViewTextString
            self.rsTextViewTextString = rsSetTextViewTextString
            /// 判断提示语是否需要展示
            if rsTextViewTextString.isEmpty {
                self.rsPlaceholderLabel.isHidden = false
            }
        }
    }
    
    /// 设置TextView的提示内容
    public var rsTextViewPlaceholder:String = "" {
        didSet{
            self.rsPlaceholderLabel.text = rsTextViewPlaceholder
        }
    }

    /// 设置TextView的提示内容的字体颜色
    public var rsTextViewPlaceholderColor:UIColor = .black {
        didSet{
            self.rsPlaceholderLabel.textColor = rsTextViewPlaceholderColor
        }
    }
    
    /// 设置TextView的背景色
    public var rsTextViewBgColor:UIColor = .white {
        didSet{
            self.rsTextView.backgroundColor = rsTextViewBgColor
        }
    }
    
    /// 设置TextView是否可编辑
    public var rsTextViewEditable:Bool = true {
        didSet{
            self.rsTextView.isEditable = rsTextViewEditable
        }
    }
    
    /// 设置TextView的内容字体颜色-默认black
    public var rsTextViewTextColor:UIColor = .black {
        didSet{
            self.rsTextView.textColor = rsTextViewTextColor
        }
    }
    
    /// 设置TextView的内容UIFont-默认14.0
    public var rsTextViewTextFont:CGFloat = 14.0 {
        didSet{
            self.rsTextView.font = UIFont.systemFont(ofSize: rsTextViewTextFont)
        }
    }
    
    /// 设置TextView的EdgeInsets默认  UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    public var rsTextViewEdgeInsets:UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) {
        didSet{
            /// 更新约束的布局
            NSLayoutConstraint.activate([
               
                self.rsTextView.topAnchor.constraint(equalTo: self.topAnchor,constant: self.rsTextViewEdgeInsets.top),
                self.rsTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:self.rsTextViewEdgeInsets.left),
                self.rsTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -self.rsTextViewEdgeInsets.bottom),
                self.rsTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-self.rsTextViewEdgeInsets.right)
            ])
            self.rsTextView.updateConstraintsIfNeeded()
        }
    }
    
}

extension RSTextView:UITextViewDelegate{
    
    /// 开始编辑
    /// - Parameter textView: textView description
    public func textViewDidBeginEditing(_ textView: UITextView) {
        
        self.rsPlaceholderLabel.isHidden = true
        self.rsTextViewTextString = textView.text
    }
    
    /// 结束编辑
    /// - Parameter textView: textView description
    public func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            self.rsPlaceholderLabel.isHidden = false
        }
        self.rsTextViewTextString = textView.text
    }
}

extension RSTextView{
    
    public override func rsAddLayoutConstraintWithSubviews() {
        super.rsAddLayoutConstraintWithSubviews()
        
        self.addSubview(self.rsTextView)
        NSLayoutConstraint.activate([
           
            self.rsTextView.topAnchor.constraint(equalTo: self.topAnchor,constant: self.rsTextViewEdgeInsets.top),
            self.rsTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:self.rsTextViewEdgeInsets.left),
            self.rsTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -self.rsTextViewEdgeInsets.bottom),
            self.rsTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant:-self.rsTextViewEdgeInsets.right)
        ])
        
        self.rsTextView.addSubview(self.rsPlaceholderLabel)
        NSLayoutConstraint.activate([
           
            self.rsPlaceholderLabel.topAnchor.constraint(equalTo: self.rsTextView.topAnchor,constant: self.rsTextViewTextFont/2.0),
            self.rsPlaceholderLabel.leadingAnchor.constraint(equalTo: self.rsTextView.leadingAnchor,constant: 2),
            self.rsPlaceholderLabel.trailingAnchor.constraint(equalTo: self.rsTextView.trailingAnchor,constant: -2)
        ])
    }
}
