//
//  RSViewController.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// RSViewController
open class RSViewController: UIViewController {
    
    /// rsNavigationBarView
    public lazy var rsNavigationBarView: RSNavigationBarView = {
        
        let rsNavigationBarView = RSNavigationBarView()
        rsNavigationBarView.frame = CGRect.init(x: 0, y: 0, width: RSScreenWidth, height: RSTopViewHeight())
        rsNavigationBarView.backgroundColor = .clear
        return rsNavigationBarView
    }()
    
    /// rlContentView
    public lazy var rsContentView: RSView = {
        
        let rsContentView = RSView()
        rsContentView.frame = CGRect.init(x: 0, y: 0, width: RSScreenWidth, height: RSScreenHeight)
        rsContentView.backgroundColor = .clear
        return rsContentView
    }()
    
    /// rsBgImageView
    public lazy var rsBgImageView: RSImageView = {
        
        let rsBgImageView = RSImageView(image: nil)
        rsBgImageView.backgroundColor = .clear
        rsBgImageView.contentMode = .scaleAspectFill
        rsBgImageView.translatesAutoresizingMaskIntoConstraints = false
        return rsBgImageView
    }()
    
    /// 设置Navigation的标题
    public var rsNavigationTitle:String = "" {
        didSet {
            self.rsNavigationBarView.rsTitleLabel.text = rsNavigationTitle
        }
    }
    
    /// 设置Navigation的标题字体的Font
    public var rsNavigationTitleFont: UIFont = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.rsNavigationBarView.rsTitleLabel.font = rsNavigationTitleFont
        }
    }
    
    /// 设置返回按钮的图片
    public var rsReturnBtnImage:String = "" {
        didSet {
            self.rsNavigationBarView.rsReturnButton.setImage(UIImage(named: rsReturnBtnImage), for: .normal)
        }
    }
    
    /// 右边的按钮-需要定义成变量-后续我们可以直接赋值给它
    public var rsRightButton: RSButton?{
        didSet {
            self.rsNavigationBarView.rsRightButton = rsRightButton
        }
    }
    
    /// 页面是否正在展示状态
    public var rsControllerActiveState:Bool = false
    
    /// 控制器释放会执行该方法
    deinit {
        debugPrint("[🌞-The controller has been released🚀🚀🚀]")
    }
    
}

extension RSViewController{
    
    /// Description
    open override func viewDidLoad() {
        super.viewDidLoad()
         
        /// 处理RSViewController的基础配置数据
        self.rsHandleViewControllerDisposition()
    }
    
    /// Description
    /// - Parameter animated: animated description
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
  
        self.rsControllerActiveState = true
    }
    
    /// Description
    /// - Parameter animated: animated description
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.rsControllerActiveState = false
    }
    
    /// 以下方法在需要的时候进行重写
    @objc open func rsAppWillResignActiveNotification(){}
    @objc open func rsAppWillEnterForegroundNotification(){}
    @objc open func rsApplicationWillTerminateNotification(){}
    @objc open func rsAppProtectedDataWillBecomeUnavailableNotification(){}
    
}

extension RSViewController{
    
    /// 处理RSViewController的基础配置
    private func rsHandleViewControllerDisposition() {
        
        /// 禁止掉所有的侧滑返回
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        /// 隐藏掉导航下面的线条
        self.navigationController?.navigationBar.shadowImage = UIImage()
        ///
        /// 返回按钮添加事件
        self.rsNavigationBarView.rsReturnButton.addTarget(self, action: #selector(rsReturnButtonClickEvent), for: .touchUpInside)
        /// 一级页面不能展示返回按钮
        if self.navigationController?.viewControllers.count ?? 0 <= 1 {
            self.rsNavigationBarView.rsReturnButton.isHidden = true
        }
        /// 添加子视图View的布局
        self.rsAddLayoutConstraintWithSubviews()
        /// 添加控制器可能会需要的通知
        self.rsHandleViewControllerNotification()
    }
    
    /// 添加处理可能会需要的通知配置
    private func rsHandleViewControllerNotification()  {
        
        /// App即将进入后台状态的通知
        NotificationCenter.default.addObserver(self, selector: #selector(rsAppWillResignActiveNotification), name: RSAppWillResignActiveNotification, object: nil)
        /// /// App即将回到前台活跃状态的通知
        NotificationCenter.default.addObserver(self, selector: #selector(rsAppWillEnterForegroundNotification), name: RSAppWillEnterForegroundNotification, object: nil)
        /// App程序即将被Kill时候的通知 【AppDelegate - applicationWillTerminate】
        NotificationCenter.default.addObserver(self, selector: #selector(rsApplicationWillTerminateNotification), name: RSApplicationWillTerminateNotification, object: nil)
        /// 手机锁定屏幕时候的通知
        NotificationCenter.default.addObserver(self, selector: #selector(rsAppProtectedDataWillBecomeUnavailableNotification), name: RSAppProtectedDataWillBecomeUnavailableNotification, object: nil)
    }
    
    /// 处理子视图的布局
    @objc open func rsAddLayoutConstraintWithSubviews() {
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.rsContentView)
        self.view.addSubview(self.rsNavigationBarView)
        ///
        /// 添加一张可能会存在的背景图-不固定高度
        self.rsContentView.addSubview(self.rsBgImageView)
        NSLayoutConstraint.activate([
           
            self.rsBgImageView.topAnchor.constraint(equalTo: self.rsContentView.topAnchor),
            self.rsBgImageView.leadingAnchor.constraint(equalTo: self.rsContentView.leadingAnchor),
            self.rsBgImageView.trailingAnchor.constraint(equalTo: self.rsContentView.trailingAnchor)
        ])
        
    }
    
    /// 返回按钮点击事件
    @objc open func rsReturnButtonClickEvent(){
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

