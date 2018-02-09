//
//  ZyDictionary.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/14.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension Dictionary {

    func zy_addEntriesFromDictionary(dic:Dictionary<String, Any>) -> Dictionary<String, Any> {
        var dicMu:Dictionary<String, Any> = dic
        for (k, v) in self {
            dicMu.updateValue(v, forKey: k as! String)
        }
        return dicMu
    }
}
