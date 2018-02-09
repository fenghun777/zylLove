//
//  ZyColor.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/13.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import UIKit

// 十六进制转颜色值
func colorWithHexString(color:String) -> UIColor {
    var cString:String = color.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    if cString.lengthOfBytes(using: String.Encoding.utf8) < 6 {
        return UIColor.clear;
    }

    if cString.hasPrefix("0X") {
        let indexI = cString.index(cString.startIndex, offsetBy: 1)
        cString = String(cString.suffix(from: indexI))
    }
    if cString.hasPrefix("#") {
        cString = String(cString.suffix(from: cString.startIndex))
    }
    if cString.lengthOfBytes(using: String.Encoding.utf8) != 6 {
        return UIColor.clear
    }

//    var start = cString.index(cString.startIndex, offsetBy: 0)
//    var end = cString.index(cString.startIndex, offsetBy: 2)
//    var range:Range = Range.init(uncheckedBounds: (lower: start, upper: end));

    let rString = cString.zy_StringRange(indexFrom: 0, indexTo: 1)
//    let rString1 = cString.substring(with: range)

//    start = cString.index(cString.startIndex, offsetBy: 2)
//    end = cString.index(cString.startIndex, offsetBy: 4)
//    range = Range.init(uncheckedBounds: (lower: start, upper: end))
    let gString = cString.zy_StringRange(indexFrom: 2, indexTo: 3)
//    let gString1 = cString[range]

//    start = cString.index(cString.startIndex, offsetBy: 4)
//    end = cString.index(cString.startIndex, offsetBy: 6);
//    range = Range.init(uncheckedBounds: (lower: start, upper: end))
    let bString = cString.zy_StringRange(indexFrom: 4, indexTo: 5)
//    let bString1 = cString.substring(with: range)

    let r:Int = zy_hexadecimalToDecimal(num: rString)
    let g:Int = zy_hexadecimalToDecimal(num: String(gString))
    let b:Int = zy_hexadecimalToDecimal(num: bString)

    return UIColor.init(red: CGFloat(Float(r)/255.0), green: CGFloat(Float(g)/255.0), blue: CGFloat(Float(b)/255.0), alpha: 1);
}

//颜色模块
func COLOR(string:String) -> UIColor {
    return colorWithHexString(color: string)
}

//默认title黑色字体
let COLOR_TEXT_TITLE = colorWithHexString(color: "333333")
//默认灰色字体
let COLOR_TEXT_GRAY = colorWithHexString(color: "666666")
//默认红色文字
let COLOR_TEXT_RED = colorWithHexString(color: "EC3732")

//默认灰色背景
let COLOR_BACKGROUND = colorWithHexString(color: "F3F3F3")
//默认红色背景
let COLOR_BACKGROUND_RED = colorWithHexString(color: "EC3732")


//默认灰色线条
let COLOR_LINE_GRAY = colorWithHexString(color: "ebecee")

