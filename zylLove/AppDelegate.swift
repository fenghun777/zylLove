//
//  AppDelegate.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/15.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
@UIApplicationMain//这个放在那里哪里先运行，这是程序入口，相当于OC的main函数
class AppDelegate: ZyAppDelegate, UNUserNotificationCenterDelegate {

    var showc:ZyBaseViewController?

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        print("\("进入子=")")

//        高德地图
        self.initAmapSet()
//        友盟
        self.initUmessageSet(launchOptions: launchOptions)

        if launchOptions == nil {
            echo(data: "launchOptions为空")
        }else{
            let url = launchOptions![UIApplicationLaunchOptionsKey.url]
            let localNotification = launchOptions![UIApplicationLaunchOptionsKey.localNotification]
            let remoteCotificationDic = launchOptions![UIApplicationLaunchOptionsKey.remoteNotification]
            if url != nil{
                echo(data: "app 通过urlscheme启动 url = \(String(describing: url))")
            }else if (localNotification != nil){
                echo(data: "app 通过本地通知启动 localNotification = \(String(describing: localNotification))")
            }else if (remoteCotificationDic != nil){
                echo(data: "app 通过远程推送通知启动 remoteCotificationDic = \(String(describing: remoteCotificationDic))")
            }
        }
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        self.getDeviceToken(deviceToken: deviceToken)
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        return true;
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        return true
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
        echo(data: "\(error)")
    }

    // MARK: iOS10以下使用这个方法接收通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        self.clickHandleNoticeInfo(userInfo: userInfo as! Dictionary<String, Any>)
    }

// MARK: iOS10以下使用这个方法接收通知 这个方法的优先级大于上面的didReceiveRemoteNotification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        UMessage.didReceiveRemoteNotification(userInfo)
        if application.applicationState == UIApplicationState.active {
//            前台，收到通知直接触发（不需要点击）
            self.presentHandleNoticeInfo(userInfo: userInfo as! Dictionary<String, Any>)
        }else if application.applicationState == UIApplicationState.inactive {
//            从后台到前台，点击通知触发
            self.clickHandleNoticeInfo(userInfo: userInfo as! Dictionary<String, Any>)
        }
        completionHandler(UIBackgroundFetchResult.newData)
    }

    


    // MARK: iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userinfo:Dictionary = notification.request.content.userInfo
        //应用处于前台时的远程推送接受
        //必须加这句代码
        UMessage.didReceiveRemoteNotification(userinfo)
        self.presentHandleNoticeInfo(userInfo: userinfo as! Dictionary<String, Any>)
        completionHandler([UNNotificationPresentationOptions.sound , UNNotificationPresentationOptions.alert, UNNotificationPresentationOptions.badge])
    }

// MARK: iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo:Dictionary = response.notification.request.content.userInfo
        self.clickHandleNoticeInfo(userInfo: userInfo as! Dictionary<String, Any>);
    }

//    MARK:  初始化高德地图
    func initAmapSet() -> Void {
        AMapServices.shared().apiKey = AMAPAPIKey
    }

//    MARK:初始化友盟
    func initUmessageSet(launchOptions:[UIApplicationLaunchOptionsKey : Any]?) -> Void {
        UMessage.start(withAppkey: UMessageAppKey, launchOptions: launchOptions, httpsEnable: true)
        #if DEBUG
            UMessage.openDebugMode(true)
        #else
            UMessage.openDebugMode(false)
        #endif

        UMessage.setAutoAlert(false)
        UMessage.registerForRemoteNotifications()
        if #available(iOS 10.0, *) {
            let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
            center.delegate = self;
            let types10:UNAuthorizationOptions = [UNAuthorizationOptions.badge, UNAuthorizationOptions.sound, UNAuthorizationOptions.alert, UNAuthorizationOptions.carPlay]
            center.requestAuthorization(options: types10, completionHandler: { (granted, error) in
                if (granted) {
                    //点击允许
                    //这里可以添加一些自己的逻辑
                    echo(data: "//点击允许")
                } else {
                    //点击不允许
                    //这里可以添加一些自己的逻辑
                    echo(data: "//点击不允许")
                }
            })
        } else {
            // Fallback on earlier versions
        }
        UMessage.setLogEnabled(false)
    }

//  MARK:   获取当前控制器
    func getCurrentController() -> Void {
        let controller = UIApplication.shared.keyWindow?.rootViewController
        let showControllers:Array<ZyBaseViewController> = controller!.childViewControllers as!
            Array<ZyBaseViewController>
        showc = showControllers.first
        for c:UIViewController in showControllers {
            if c is ZyBaseViewController {
                echo(data: "\(c)")
                showc = (c as! ZyBaseViewController)
            }
        }
    }


//  MARK:  点击获取通知相关信息并处理
    func clickHandleNoticeInfo(userInfo:Dictionary<String, Any>) -> Void {

        UMessage.didReceiveRemoteNotification(userInfo)
        let typeStr:String = userInfo["type"] as! String
        if typeStr == "order" {
            let idStr:String = userInfo["id"] as! String
            
        }else if typeStr == "product_order"{
            let idStr:String = userInfo["id"] as! String
            
        }else{
            echo(data: "未知的类型")
        }
    }

    //  MARK:  前台获取通知相关信息并处理
    func presentHandleNoticeInfo(userInfo:Dictionary<String, Any>) -> Void {
        UMessage.didReceiveRemoteNotification(userInfo)
        let typeStr:String = userInfo["type"] as! String
        if typeStr == "order" {
            let idStr:String = userInfo["id"] as! String
            
        }else if typeStr == "product_order"{
            let idStr:String = userInfo["id"] as! String
            
        }else{
            echo(data: "未知的类型")
        }
    }


//    MARK: 获取devicetoken
    func getDeviceToken(deviceToken:Data) -> Void {
        UMessage.registerDeviceToken(deviceToken)

        let device = NSData(data: deviceToken)
        let deviceId:String = device.description.replacingOccurrences(of:"<", with:"").replacingOccurrences(of:">", with:"").replacingOccurrences(of:" ", with:"")
        print("我的deviceToken：\(deviceId)")
        let userdefault:UserDefaults = UserDefaults.standard
        userdefault.set(deviceId, forKey: "deviceToken")
        userdefault.synchronize();
    }
}
