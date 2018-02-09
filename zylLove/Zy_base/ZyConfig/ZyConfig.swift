
//
//  ZyConfig.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/13.
//  Copyright © 2017年 Zyy. All rights reserved.
//
//swift中是不能使用宏定义语法的，但是因为命名空间的缘故，我们可以给我们的项目添加一个空的Const.swift文件，在其中，我们将原本oc中不需要接受参数的宏，定义成let常量，将需要接受参数的宏定义成函数即可，由于我们的整个项目共享命名空间，我们就可以在项目内的任何地方直接使用Const.swift中定义的这些公共的常量和函数
import Foundation
import UIKit

let CLIENT = "10"//iOS是10  安卓是20
let AppName = "新能源"// app的名字

let WIDTH = UIScreen.main.bounds.size.width
let HEIGHT = UIScreen.main.bounds.size.height

//设置默认字体大小
func FONT(s:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: s)
}

//设置字体大小(size)，字体(name)，粗细(bold)，斜体(italic)
func FONT(size:CGFloat, name:NSInteger, bold:CGFloat, italic:CGFloat) -> UIFont {
    let arrFonts:Array = UIFont.familyNames;
    var nameStr:String = "Apple SD Gothic Neo"
    if arrFonts.count > name {
        nameStr = arrFonts[name]
    }
    var font:UIFont = UIFont.init(name: nameStr, size: size)!
    font = UIFont.boldSystemFont(ofSize: bold);
    font = UIFont.italicSystemFont(ofSize: italic)
    if #available(iOS 8.2, *) {
        font = UIFont.systemFont(ofSize: size, weight: UIFont.Weight(rawValue: bold))
    } else {
        // Fallback on earlier versions
    };
    return font;
}

//自这里开始 进入debug模式
//let WWWDEBUG = "打开注释即可开启外网调试"

#if DEBUG // 判断是否在测试环境下
#if WWWDEBUG
let API_HOST_API = "http://sk.yanguangsoft.com" //如果定义了WWWDEBUG，
    #else
let API_HOST_API = "http://sk.yanguangsoft.com"//内网测试
#endif
#else
let API_HOST_API = "http://sk.yanguangsoft.com"// 线上测试
#endif

let API_HOST_IMAGE = "http://skcharging.yanguangsoft.com/"

#if DEBUG
    func echo(data:Any) -> Void {
        print("\(data)")
    }
#else
    func echo(data:Any) -> Void {

    }
#endif


//为了存储UserDefaults的相关数据，定义的全局变量

let UD_id                      = "UD_id"
let UD_name                = "UD_name"
let UD_mobile               = "UD_mobile"
let UD_pic                    = "UD_pic"
let UD_sex                    = "UD_sex"
let UD_age                    = "UD_age"
let UD_trade                 = "UD_trade"
let UD_company           = "UD_company"
let UD_profession         = "UD_profession"
let UD_balance             = "UD_balance"
let UD_credit                = "UD_credit"
let UD_status               = "UD_status"
let UD_access_token     = "UD_access_token"

//自动登录
let UD_isLogin               = "UD_isLogin" //bool类型













