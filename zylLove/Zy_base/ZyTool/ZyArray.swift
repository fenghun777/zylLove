//
//  ZyArray.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/18.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension Array {

//    目前只能获取字符串的下标
    func zy_indexOfKey(key:String) -> Int {
        for i in 0 ..< self.count {
            let value:String = self[i] as! String
            if value == key {
                return i;
            }
        }
        return 1000000;
    }
}
