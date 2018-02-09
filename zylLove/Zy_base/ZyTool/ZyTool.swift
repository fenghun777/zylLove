
//
//  ZyTool.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/13.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import UIKit

 // MARK: - 十六进制转十进制 
func zy_hexadecimalToDecimal(num:String) -> Int {
    let str = num.uppercased()
    var sum = 0
    for i in str.utf8 {
        sum = sum * 16 + Int(i) - 48 // 0-9 从48开始
        if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
            sum -= 7
        }
    }
    return sum
}

//MARK: 默认拼接的参数
func zy_clientPrepareHttpParameters(dic:Dictionary<String, Any>) -> Dictionary<String, Any> {
    var dictionary:Dictionary<String, Any> = Dictionary.init()
    let userdefault:UserDefaults = UserDefaults.standard
    let tokenStr = userdefault.object(forKey: UD_access_token)
    if tokenStr is String {
        dictionary = ["access-token":tokenStr as! String];
    }else{
        echo(data: "未拼接token");
    }
    dictionary = dictionary.zy_addEntriesFromDictionary(dic: dic)
    return dictionary;
}

//MARK: get方法拼接url的参数
func zy_clientPrepareHttpParametersToURL(dic:Dictionary<String, Any>, url:String) -> String {
    var urlStr = url + "?"
    for (key, value) in dic {
        urlStr = urlStr + "\(key)=" + "\(value)&"
    }

    let indexEnd = urlStr.index(urlStr.endIndex, offsetBy: -1)
    let suffixEnd = urlStr.substring(from: indexEnd)
    if (suffixEnd == "&") {
        urlStr.remove(at: indexEnd)        
    }
    return urlStr;
}


/*
MARK: label宽度自适应
  - Parameters:
   - content: 文字
   - heightContent: 最大高度
  - attributes: 字体，行距等
   - Returns: 高度
 */
func zy_getContentSizeWidthFont(content:String, heightContent:CGFloat, font:CGFloat) -> CGFloat {
    let size2 = CGSize(width:0, height:heightContent)
    let font:UIFont = UIFont.systemFont(ofSize: font)
    let attribute = [NSAttributedStringKey.font:font]
    let rect = content.boundingRect(with: size2, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attribute , context: nil);
    return rect.size.width
}

//MARK:等比获取size
func zy_resizeSize(osize:CGSize, sizeTo:CGSize) -> CGSize {
    var size:CGSize = sizeTo
    var bl = min(size.width/osize.width, size.height/osize.height)
    if bl == 0 {
        bl = max(size.width / osize.width, size.height / osize.height)
    }

    if (osize.width <= size.width && osize.height <= size.height) {
        return osize;
    }else{
        size.width = (osize.width * bl * 100) / 100;
        size.height = (osize.height * bl * 100) / 100;
    }
    return size;
}

//MARK:时间戳转时间
func zy_timeStampToTime(timeStamp:String, type:NSInteger) -> String {
    let formatter:DateFormatter = DateFormatter.init()
    switch type {
    case 0:
        formatter.dateFormat = "YY-MM-dd HH:mm"
        break
    case 1:
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        break
    case 2:
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        break
//    case 3:
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        break
//    case 4:
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        break
//    case 5:
//        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//        break
    default:
        formatter.dateFormat = "YY-MM-dd HH:mm"
        echo(data: "设置时间格式")
        break
    }
    let timeZone:TimeZone = TimeZone.init(identifier: "Asia/Shanghai")!
    formatter.timeZone = timeZone
    if (timeStamp == "")||(timeStamp.isEmpty) {
        return ""
    }else{
        let confromTimesp:Date = Date.init(timeIntervalSince1970: TimeInterval(timeStamp)!)
        let timeStr:String = formatter.string(from: confromTimesp)
        return timeStr
    }
}

//MARK:时间转时间戳
func zy_timeToTimeStamp(time:String, type:NSInteger) -> String {
    let formatter:DateFormatter = DateFormatter.init()
    switch type {
    case 0:
        formatter.dateFormat = "YY-MM-dd HH:mm"
        break
    case 1:
        formatter.dateFormat = "YYYY-MM-dd HH:mm"
        break
    case 2:
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        break
        //    case 3:
        //        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        //        break
        //    case 4:
        //        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        //        break
        //    case 5:
        //        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    //        break
    default:
        formatter.dateFormat = "YY-MM-dd HH:mm"
        echo(data: "设置时间格式")
        break
    }
    let timeZone:TimeZone = TimeZone.init(identifier: "Asia/Shanghai")!
    formatter.timeZone = timeZone

//    let timeStr:String = "2011-01-26 17:40:50"
    let date:Date = formatter.date(from: time)!
    let timeSp:String = String(date.timeIntervalSince1970)
    return timeSp
}

//获取当前时间的时间戳
func zy_getCurrentTimeStamp() -> String {
    let formatter:DateFormatter = DateFormatter.init()
    let timeZone:TimeZone = TimeZone.init(identifier: "Asia/Shanghai")!
    formatter.timeZone = timeZone
    let date:Date = Date.init()
    let timeSp:String = String(date.timeIntervalSince1970)
    return timeSp
}

//MARK: 拨打电话
func zy_dialPhone(tel:String) -> Void  {
    let phoneStr:String = "telprompt://" + tel
    UIApplication.shared.openURL(URL.init(string: phoneStr)!)
}
//MARK: 发送信息
func zy_sendMessage(tel:String) -> Void {
    let phoneStr:String = "sms://" + tel
    UIApplication.shared.openURL(URL.init(string: phoneStr)!)
}














