//
//  RSCollectionReusableView.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 29.10.24.
//

import UIKit
import Foundation

/// RSCollectionReusableView
class RSCollectionReusableView: UICollectionReusableView {
    
    /// rsIndexPath
    open var rsIndexPath:IndexPath = RSDefaultIndexPath
    
    /// Description
    /// - Parameter frame: frame description
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rsAddLayoutConstraintWithSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RSCollectionReusableView{
    
    @objc open func rsAddLayoutConstraintWithSubviews() {}
}
