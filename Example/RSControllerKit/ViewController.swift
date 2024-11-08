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
    
    /// rsTextView
    lazy var rsTextView: RSTextView = {
        
        let rsTextView = RSTextView(frame: CGRect.init(x: (RSScreenWidth - 200)/2, y: 100, width: 200, height: 100))
        rsTextView.rsTextViewEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        rsTextView.rsTextViewPlaceholder = "HEHEMOBI"
        rsTextView.rsTextViewTextFont = 16.0
        rsTextView.rsTextViewTextColor = .red
        rsTextView.rsCornerRadius = 10
        rsTextView.rsBorderColor = .orange
        return rsTextView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(self.rsTextView)
        
        let okButton = UIButton.init(type: .system)
        okButton.setTitle("OKK", for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        okButton.addTarget(self, action: #selector(okButtonClickEvent), for: .touchUpInside)
        okButton.frame = CGRect.init(x: (RSScreenWidth - 100)/2, y: 400, width: 100, height: 100)
        self.view.addSubview(okButton)
    }
    
    @objc func okButtonClickEvent(){
        
        self.view.endEditing(true)
        debugPrint(self.rsTextView.rsTextViewTextString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

