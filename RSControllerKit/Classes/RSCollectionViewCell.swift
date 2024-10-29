//
//  RSCollectionViewCell.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSCollectionViewCell
class RSCollectionViewCell: UICollectionViewCell {
    
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

extension RSCollectionViewCell{
    
    @objc open func rsAddLayoutConstraintWithSubviews() {}
}
