//
//  RSKey.swift
//  RSExtension
//
//  Created by Mr.RisingSun on 28.10.24.
//

import UIKit
import Foundation

/// ----------------------------------------------------------------------------

/// App即将进入后台状态的通知
public let RSAppWillResignActiveNotification = Notification.Name("rsApplicationWillResignActive")
/// App程序即将被Kill时候的通知 【AppDelegate - applicationWillTerminate】
public let RSApplicationWillTerminateNotification = Notification.Name("rsApplicationWillTerminate")
/// App即将回到前台活跃状态的通知
public let RSAppWillEnterForegroundNotification = Notification.Name("rsApplicationWillEnterForeground")
/// 手机锁定屏幕时候的通知
public let RSAppProtectedDataWillBecomeUnavailableNotification = Notification.Name("rsApplicationProtectedDataWillBecomeUnavailable")
 

/// ----------------------------------------------------------------------------
/// 默认的UIEdgeInsets
public let RSDefaultEdgeInsets = UIEdgeInsets.zero
/// 默认的IndexPath
public let RSDefaultIndexPath  = IndexPath(row: 0, section: 0)

/// 屏幕的宽和高
public let RSScreenWidth  = UIScreen.main.bounds.size.width
public let RSScreenHeight = UIScreen.main.bounds.size.height

/// 状态栏高度
public let RSStatusBarHeight = {
     
    let firstObj = UIApplication.shared.windows.first?.windowScene?.statusBarManager
    if (firstObj?.statusBarFrame.size.height ?? 20.0) == 0.0{
        return 20.0
    }
    return Double(firstObj?.statusBarFrame.size.height ?? 20.0)
}

/// 顶部状态栏+NavigationView的高度
public let RSTopViewHeight = {
    
    return RSStatusBarHeight() + 44.0
}

