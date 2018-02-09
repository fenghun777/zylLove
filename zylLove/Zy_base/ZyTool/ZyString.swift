//
//  ZyString.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/10/10.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension String {

    func zy_StringRange(indexFrom:NSInteger, indexTo: NSInteger) -> String {
        //通过范围获取字符串中的一个子串,先截取前indexTo + 1个，在截取后(indexTo - indexFrom + 1)个
        let indexT = self.index(self.startIndex, offsetBy: (indexTo + 1))
        let preStr = String(self.prefix(upTo: indexT))

        let indexF = preStr.index(preStr.endIndex, offsetBy: -(indexTo - indexFrom + 1))
        let subStr = String(preStr.suffix(from: indexF))

        return subStr
    }
}
