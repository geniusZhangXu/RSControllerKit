//
//  RSScrollStackView.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSScrollStackView
class RSScrollStackView: RSView {
    
    /// fizzScrollView
    lazy var rsScrollView: UIScrollView = {
        
        let rsScrollView = UIScrollView()
        rsScrollView.backgroundColor = .clear
        rsScrollView.showsHorizontalScrollIndicator = false
        rsScrollView.translatesAutoresizingMaskIntoConstraints = false
        return rsScrollView
    }()
    
    /// rsStackView
    open lazy var rsStackView: UIStackView = {
        
        let rsStackView = UIStackView()
        rsStackView.axis = .vertical
        rsStackView.alignment = .center
        rsStackView.translatesAutoresizingMaskIntoConstraints = false
        return rsStackView
    }()
    
}

extension RSScrollStackView{
    
    override func rsAddLayoutConstraintWithSubviews() {
        super.rsAddLayoutConstraintWithSubviews()
        
        self.addSubview(self.rsScrollView)
        NSLayoutConstraint.activate([
           
            self.rsScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.rsScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.rsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.rsScrollView.widthAnchor.constraint(equalToConstant: RSScreenWidth)
        ])
        
        self.rsScrollView.addSubview(self.rsStackView)
        NSLayoutConstraint.activate([
           
            self.rsStackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.rsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.rsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.rsStackView.widthAnchor.constraint(equalToConstant: RSScreenWidth)
        ])
        
    }
    
}
