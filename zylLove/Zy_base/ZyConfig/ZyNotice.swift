//
//  ZyNotice.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/18.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation


//通知模块
func ZyNoticePost(n:String, o:Any?, u:Any?) -> Void {
    NotificationCenter.default.post(name: NSNotification.Name(n), object: o, userInfo: u as? [AnyHashable : Any])
}

func ZyNoticeAdd(selfAny:Any, s:Selector, n:String, o:Any?) -> Void {
    NotificationCenter.default.addObserver(selfAny, selector: s, name: NSNotification.Name(n), object: o)
}

//初始模板 定义所有通知
//let Zy_Notice_getNotice = "Zy_Notice_getNotice"//获取推送信息











