//
//  RSWebController.swift
//  MrRisingSun
//
//  Created by Mr.RisingSun on 29.10.24.
//

import UIKit
import WebKit
import Foundation

/// RSWebController
public class RSWebController: RSViewController {
    
    /// WKWebViewConfiguration
    private lazy var rsConfiguration: WKWebViewConfiguration = {
        
        let rsConfiguration = WKWebViewConfiguration()
        return rsConfiguration
    }()

    /// WKWebView
    private lazy var rsWkWebView: WKWebView = {
        
        let rsWkWebView = WKWebView.init(frame: CGRect.zero, configuration: self.rsConfiguration)
        rsWkWebView.uiDelegate = self
        rsWkWebView.navigationDelegate = self
        rsWkWebView.backgroundColor = .white
        rsWkWebView.translatesAutoresizingMaskIntoConstraints = false
        /// 监听网页加载的进度
        rsWkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return rsWkWebView
    }()
    
    /// UIProgressView
    private lazy var rsProgressView : UIProgressView = {
        
        let rsProgressView = UIProgressView.init()
        rsProgressView.trackTintColor = UIColor.clear
        rsProgressView.translatesAutoresizingMaskIntoConstraints = false
        return rsProgressView
    }()
    
    /// rsLoadUrlString
    private var rsLoadUrlString:String = ""
    
    /// 根据加载的Url初始化控制器
    /// - Parameter rsLoadUrlString: rsLoadUrlString description
    public convenience init(_ rsLoadUrlString:String) {
        self.init()
        
        self.rsLoadUrlString = rsLoadUrlString
    }
    
}

extension RSWebController {
    
    /// Description
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        /// 加载Web需要展示的内容
        self.rsLoadingWithWebSourceUrl()
    }
    
    /// 加载Web需要展示的内容
    private func rsLoadingWithWebSourceUrl(){
        
        /// 超过15s按照加载超时处理
        guard let rsLoadUrlString = URL(string:self.rsLoadUrlString) else { return }
        let rsRequest = URLRequest.init(url: rsLoadUrlString, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15)
        self.rsWkWebView.load(rsRequest)
    }
}

extension RSWebController:WKUIDelegate,WKNavigationDelegate{
    
    /// 网页加载完毕
    /// - Parameter webView: webView description
    /// - Parameter navigation: navigation description
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      
        /// 延时0.5秒消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.rsProgressView.isHidden = true
        }
    }
    
    /// 监听网页加载进度
    /// - Parameter keyPath: keyPath description
    /// - Parameter object:  object description
    /// - Parameter change:  change description
    /// - Parameter context: context description
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    
        self.rsProgressView.progress = Float(self.rsWkWebView.estimatedProgress)
    }
    
    /// 加载临时导航出错  网络错误会走这里
    /// - Parameters:
    ///   - webView: webView description
    ///   - navigation: navigation description
    ///   - error: error description
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        /// 去掉加载进度
        UIView.animate(withDuration: 0.5) {
            
           self.rsProgressView.progress = 0.0
           self.rsProgressView.isHidden = true
       }
    }
    
}

extension RSWebController{
    
    public override func rsAddLayoutConstraintWithSubviews() {
        super.rsAddLayoutConstraintWithSubviews()
        
        self.rsContentView.addSubview(self.rsWkWebView)
        NSLayoutConstraint.activate([
           
            self.rsWkWebView.bottomAnchor.constraint(equalTo: self.rsContentView.bottomAnchor),
            self.rsWkWebView.leadingAnchor.constraint(equalTo: self.rsContentView.leadingAnchor),
            self.rsWkWebView.trailingAnchor.constraint(equalTo: self.rsContentView.trailingAnchor),
            self.rsWkWebView.topAnchor.constraint(equalTo: self.rsContentView.topAnchor, constant: RSTopViewHeight() + 2)
        ])
        
        self.rsContentView.addSubview(self.rsProgressView)
        NSLayoutConstraint.activate([
           
            self.rsProgressView.heightAnchor.constraint(equalToConstant: 2),
            self.rsProgressView.leadingAnchor.constraint(equalTo: self.rsContentView.leadingAnchor),
            self.rsProgressView.trailingAnchor.constraint(equalTo: self.rsContentView.trailingAnchor),
            self.rsProgressView.topAnchor.constraint(equalTo: self.rsContentView.topAnchor, constant: RSTopViewHeight())
        ])
    }
}
