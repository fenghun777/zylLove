//
//  ZyAppDelegate.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/12.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import UIKit

class ZyAppDelegate: UIResponder, UIApplicationDelegate,UITabBarControllerDelegate {
    var window: UIWindow?

    var userdefaults:UserDefaults = UserDefaults.standard

    // 当应用程序启动完毕的时候就会调用(系统自动调用)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        print("\("进入父")")
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window!.makeKeyAndVisible();
        self.window!.backgroundColor = UIColor.white;


        let isLogin:Bool = userdefaults.bool(forKey: UD_isLogin)
        if (isLogin == false) {
            self.signIn()
        }else{
            self.enter()
        }
        self.setNav()
        self.setUIApplication()
        return true
    }

    // 即将失去活动状态的时候调用(失去焦点, 不可交互)
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    // 应用程序进入后台的时候调用
    // 一般在该方法中保存应用程序的数据, 以及状态
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    }
    // 应用程序即将进入前台的时候调用
    // 一般在该方法中恢复应用程序的数据,以及状态
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("\("进入父")")
    }
    // 重新获取焦点(能够和用户交互)
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    // 应用程序即将被销毁的时候会调用该方法
    // 注意:如果应用程序处于挂起状态的时候无法调用该方法
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // 应用程序接收到内存警告的时候就会调用
    // 一般在该方法中释放掉不需要的内存
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {

    }

    func setUIApplication() {
        let app:UIApplication = UIApplication.shared
        app.applicationIconBadgeNumber = 111

        //设置指示器的联网动画
        app.isNetworkActivityIndicatorVisible = true
        //设置状态栏的样式
        app.statusBarStyle = UIStatusBarStyle.default

        //设置状态栏是否隐藏,ios9.0之后需要Info.plist添加以下两条
        //        1.在Info.plist中增加 Status bar is initially hidden一行,选择为 YES,
        //        2.还需增加 View controller-based status bar appearance 一行,选择为 NO。
        app.isStatusBarHidden = true
    }

    func setNav() -> Void {
        let bar = UINavigationBar.appearance()
        //设置显示的颜色
        bar.barTintColor = UIColor.white

        //设置字体颜色
        bar.tintColor = UIColor.black

        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.black]
    }

    func signIn() -> Void {
        let sivc:SignInViewController = SignInViewController();
        let nav = UINavigationController(rootViewController:sivc);
        self.window!.rootViewController = nav;
    }


    func enter() -> Void {
        let sivc:SignInViewController = SignInViewController();
        let nav = UINavigationController(rootViewController:sivc);
        self.window!.rootViewController = nav;
    }

}
