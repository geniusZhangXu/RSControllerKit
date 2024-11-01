//
//  RSCollectionReusableView.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 29.10.24.
//

import UIKit
import Foundation

/// RSCollectionReusableView
public class RSCollectionReusableView: UICollectionReusableView {
    
    /// rsIndexPath
    public var rsIndexPath:IndexPath = RSDefaultIndexPath
    
    /// Description
    /// - Parameter frame: frame description
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.rsAddLayoutConstraintWithSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RSCollectionReusableView{
    
    @objc public func rsAddLayoutConstraintWithSubviews() {}
}
