//
//  RSNavigationController.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSNavigationController
open class RSNavigationController: UINavigationController {
    
    /// 参数的具体描述在便利初始化方法里面
    public var rsHidesBottomBarWhenPushedController:[UIViewController.Type] = []
    
    /// 便利初始化RSNavigationController
    /// - Parameters:
    ///   - rsRootController: rsRootController description
    ///   - rsHidesBottomBarWhenPushedController: rsHidesBottomBarWhenPushedController 那些控制器在popToViewController方法中需要特殊处理hidesBottomBarWhenPushed
    public convenience init(rsRootController:UIViewController,_ rsHidesBottomBarWhenPushedController:[UIViewController.Type] = []) {
        
        self.init(rootViewController: rsRootController)
        
        self.rsHidesBottomBarWhenPushedController.removeAll()
        self.rsHidesBottomBarWhenPushedController.append(contentsOf: rsHidesBottomBarWhenPushedController)
    }
    
}

extension RSNavigationController{
    
    /// viewDidLoad
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        /// 隐藏掉这两个是为了方便我们自定义重写
        self.navigationBar.isHidden = true
        self.navigationItem.hidesBackButton = true
    }
    
    /// 重写Push-隐藏底部的View
    /// - Parameters:
    ///   - viewController: viewController description
    ///   - animated: animated description
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.viewControllers.count > 0{
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /// Pop的时候显示出来
    /// - Parameters:
    ///   - viewController: viewController description
    ///   - animated: animated description
    /// - Returns: description
    open override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        
        guard let lastController = self.viewControllers.last else { return super.popToViewController(viewController, animated: animated)}
        
        if !self.rsHidesBottomBarWhenPushedController.isEmpty {
            
            for item in self.rsHidesBottomBarWhenPushedController {
                
                if (lastController.isKind(of:item.self)) && self.viewControllers.count == 3 {
                    viewController.hidesBottomBarWhenPushed = false
                }
            }
        }else{
            
            if self.viewControllers.count > 1{
                viewController.hidesBottomBarWhenPushed = true
            }else{
                viewController.hidesBottomBarWhenPushed = false
            }
        }
        return super.popToViewController(viewController, animated: animated)
    }
    
    /// Description
    /// - Parameter animated: animated description
    /// - Returns: description
    open override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        
        self.topViewController?.hidesBottomBarWhenPushed = false
        return super.popToRootViewController(animated: animated)
    }
    
}
