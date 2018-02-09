//
//  ZyBaseViewController.swift
//  qingpai_app_ios
//
//  Created by iosdev1 on 2017/5/11.
//  Copyright © 2017年 ygsoft. All rights reserved.
//

import UIKit

class ZyBaseViewController: UIViewController {

    var TabBarHidden = false//为true下面的tabbar 隐藏    为false的时候下面的tabbar显示
//    let ygani:ZyAnimationView = ZyAnimationView.init()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.view.backgroundColor = UIColor.white
        self.controllerInit()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = TabBarHidden
//        self.setNotices()
    }
    //    基本通知
//    func setNotices() -> Void {
//        ZyNoticeAdd(selfAny: self, s: #selector(pushToNotice(obj:)), n: Zy_Notice_getNotice, o: "")
//    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
    }

    func controllerInit() -> Void {
        TabBarHidden = true
        self.setTabBarHidden(tabBarHidden: TabBarHidden)
    }
    
    func showHUD(title:String, content:String) -> Void {
//        ygani.activityIndicatorStartViewUI()
    }
    
    func hideHUD() -> Void {
//        ygani.activityIndicatorStopViewUI()
    }
    
    func setTabBarHidden(tabBarHidden:Bool) -> Void {
        TabBarHidden = tabBarHidden
        if tabBarHidden == true {
            let backButton = UIBarButtonItem.init(image: UIImage.init(named: "top_back"), style: UIBarButtonItemStyle.done, target: self, action: #selector(navBack))
            self.navigationItem.setLeftBarButton(backButton, animated: false)
        }else {
            self.navigationItem.setLeftBarButton(nil, animated: false)
        }
    }
    
    @objc func navBack() -> Void {
        self.backController()
    }
    
    func backController() -> Void {
        self.backController(lever: 1)
    }
    
    func backController(lever:NSInteger) -> Void {
        let navcontroller = TabBarHidden ? self.navigationController : self.tabBarController?.navigationController
        var viewcontrollers = navcontroller?.viewControllers
        if lever >= (viewcontrollers?.count)! {
            navcontroller?.popToRootViewController(animated: true)
            return
        }
        for _ in 0 ..< lever {
            viewcontrollers?.removeLast()
        }
        navcontroller?.setViewControllers(viewcontrollers!, animated: true)
    }
    
    func pushController(controller:UIViewController) -> Void {
//        self.pushController(controller: controller, lever: 0)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushController(controller:UIViewController, lever:NSInteger) -> Void {
        let navcontroller = TabBarHidden ? self.navigationController : self.tabBarController?.navigationController
        var viewcontrollers:Array = (navcontroller?.viewControllers)!
        if (lever >= (viewcontrollers.count))||lever == 0 {
            navigationController?.pushViewController(controller, animated: true)
            return
        }
        for _ in 0 ..< lever {
            viewcontrollers.removeLast()
        }
        viewcontrollers.append(controller)
        navigationController?.setViewControllers(viewcontrollers, animated: true)
    }

    deinit {
        echo(data: "释放内存")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
