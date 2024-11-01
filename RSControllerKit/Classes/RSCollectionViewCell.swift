//
//  RSCollectionViewCell.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSCollectionViewCell
public class RSCollectionViewCell: UICollectionViewCell {
    
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

extension RSCollectionViewCell{
    
    @objc public func rsAddLayoutConstraintWithSubviews() {}
}
