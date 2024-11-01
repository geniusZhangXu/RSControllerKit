//
//  ViewController.swift
//  RSControllerKit
//
//  Created by geniusZhangXu on 10/29/2024.
//  Copyright (c) 2024 geniusZhangXu. All rights reserved.
//

import UIKit
import RSControllerKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /// RSView
        let rsView = RSView()
            
        /// RSButton
        let rsButton = RSButton.init("image")
        
        /// RSLabel
        let rsLabel = RSLabel.init(frame: CGRect.zero)
        
        /// RSImageView
        let rsImageView = RSImageView.init(rsImageName: "image")
        
        /// RSScrollStackView
        let rsScrollStackView = RSScrollStackView()
        rsScrollStackView.rsStackView.addArrangedSubview(rsImageView)
        
        /// RSViewController
        let rsViewController = RSViewController()
        rsViewController.rsReturnBtnImage = "image"
        
        /// RSWebController
        let rsWebController = RSWebController("load-url")
        
        /// RSNavigationController
        let rsNavigationController = RSNavigationController(rootViewController: rsViewController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

