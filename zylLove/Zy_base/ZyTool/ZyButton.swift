//
//  ZyButton.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/22.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension UIButton {

    class func initWithEvent(title:String, font:CGFloat, color:UIColor, bgcolor:UIColor, radius:CGFloat, btnClosure:@escaping (_ btn:UIButton) -> Void) -> UIButton {
        let btn:UIButton = UIButton.init()
        btn.setTitle(title, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        btn.setTitleColor(color, for: UIControlState.normal)
        btn.backgroundColor = bgcolor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = radius

        btn.bk_(whenTouches: 1, tapped: 1) {
            btnClosure(btn)
        }
        return btn
    }

    class func initWith(title:String, font:CGFloat, color:UIColor, bgcolor:UIColor, radius:CGFloat) -> UIButton {
        let btn:UIButton = UIButton.init()
        btn.setTitle(title, for: UIControlState.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: font)
        btn.setTitleColor(color, for: UIControlState.normal)
        btn.backgroundColor = bgcolor
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = radius
        return btn
    }

    class func initWith(imageNormal:UIImage, radius:CGFloat, btnClosure:@escaping (_ btn:UIButton) -> Void) -> UIButton {
        let btn:UIButton = UIButton.init()
        btn.setImage(imageNormal, for: UIControlState.normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = radius
        btn.bk_(whenTouches: 1, tapped: 1) {
            btnClosure(btn)
        }
        return btn
    }




}
