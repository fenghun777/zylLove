//
//  ZyLabel.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/21.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension UILabel {

    class func initWith(title:String, font:CGFloat, color:UIColor) -> UILabel {
        return initWith(title: title, font: font, color: color, bgColor: UIColor.white, radius: 0.0);
    }

    class func initWith(title:String, font:CGFloat, color:UIColor, bgColor:UIColor, radius:CGFloat) -> UILabel {
        let lbl = UILabel.init()
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: font);
        lbl.textColor = color
        lbl.backgroundColor = bgColor
        if radius > 0.0 {
            lbl.layer.cornerRadius = CGFloat(radius)
            lbl.layer.masksToBounds = true
        }
        return lbl;
    }

}
