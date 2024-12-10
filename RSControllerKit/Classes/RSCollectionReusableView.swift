//
//  RSCollectionReusableView.swift
//  MrRisingSun
//
//  Created by Mr.RisingSun on 29.10.24.
//

import UIKit
import Foundation

/// RSCollectionReusableView
open class RSCollectionReusableView: UICollectionReusableView {
    
    /// rsIndexPath
    public var rsIndexPath:IndexPath = RSDefaultIndexPath
    
    /// Description
    /// - Parameter frame: frame description
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rsAddLayoutConstraintWithSubviews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RSCollectionReusableView{
    
    @objc open func rsAddLayoutConstraintWithSubviews() {}
}
