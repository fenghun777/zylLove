
//
//  ZyUI.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/14.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import UIKit


///渐隐弹出框，提示
///
/// - Parameters:
///   - message: 文字
func showMessage(message:String)  {
    if message.isEmpty||message == "" {
        return;
    }

    let window:UIWindow = UIApplication.shared.keyWindow!;
    let showview:UIView = UIView.init(frame: CGRect(x:1, y:1, width:1, height:1))
    showview.alpha = 1.0
    showview.layer.masksToBounds = true
    showview.layer.cornerRadius = 5.0
    showview.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    window.addSubview(showview)

    let label:UILabel = UILabel.init()
    label.text = message;
    label.font = UIFont.systemFont(ofSize: 14.0)

    let width:CGFloat = zy_getContentSizeWidthFont(content: message, heightContent: 17, font: 17)
    label.frame = CGRect(x:10, y:5, width:width, height:20)
    showview.addSubview(label)
    showview.frame = CGRect(x:(WIDTH - width - 20)/2, y:HEIGHT/2, width:width+20, height:30);

    UIView.animate(withDuration: 2, animations: {
        showview.alpha = 0
    }) { (true) in
        showview.removeFromSuperview()
    }
}

//点击空白处消失
func backGroundView() -> UIView {
    let view:UIView = UIView.init(frame: UIScreen.main.bounds)
    UIApplication.shared.keyWindow?.addSubview(view)

    let bgView = UIView.init()
    view.addSubview(bgView)
    bgView.snp.makeConstraints { (make) in
        make.edges.equalTo(view)
    }
    bgView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    bgView.bk_(whenTouches: 1, tapped: 1) {
        view.removeFromSuperview()
    }
    return view;
}

//MARK:点击空白处不消失
func backGroundViewNo() -> UIView {
    let view:UIView = UIView.init(frame: UIScreen.main.bounds)
    UIApplication.shared.keyWindow?.addSubview(view)

    let bgView = UIView.init()
    view.addSubview(bgView)
    bgView.snp.makeConstraints { (make) in
        make.edges.equalTo(view)
    }
    bgView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
    return view;
}


//默认提示框
func alertViewForTitle(title:String, sureClosure:@escaping (_ btn:UIButton)->Void, cancelClosure:@escaping (_ btn:UIButton)->Void) -> Void {
    let bgview:UIView = backGroundViewNo()

    let mainView:UIView = UIView.init()
    bgview.addSubview(mainView)
    mainView.snp.makeConstraints { (make) in
        make.center.equalTo(bgview)
        make.size.equalTo(CGSize(width:WIDTH - 40, height:150))
    }
    mainView.backgroundColor = UIColor.white
    mainView.layer.masksToBounds = true
    mainView.layer.borderWidth = 0.5
    mainView.layer.cornerRadius = 5

    let lblRemark:UILabel = UILabel.initWith(title: "提示", font: 17.0, color: COLOR_TEXT_TITLE)
    mainView.addSubview(lblRemark)
    lblRemark.snp.makeConstraints { (make) in
        make.centerX.equalTo(mainView)
        make.top.equalTo(mainView).offset(10.0);
        make.size.equalTo(CGSize(width:100, height:30))
    }
    lblRemark.textAlignment = NSTextAlignment.center

    let lblTitle:UILabel = UILabel.initWith(title: title, font: 17.0, color: COLOR_TEXT_GRAY)
    mainView.addSubview(lblTitle)
    lblTitle.snp.makeConstraints { (make) in
        make.center.equalTo(mainView)
        make.size.equalTo(CGSize(width:200, height:30))
    }
    lblTitle.textAlignment = NSTextAlignment.center

    let arrBtns:Array = ["取消", "确定"]
    for i in 0 ..< arrBtns.count {
        let btn:UIButton = UIButton.initWithEvent(title: arrBtns[i], font: 14, color: COLOR_TEXT_RED, bgcolor: UIColor.white, radius: 0, btnClosure: { (button) in
            if i == 0{
                cancelClosure(button)
                bgview.removeFromSuperview()
            }else{
                sureClosure(button);
                bgview.removeFromSuperview()
            }
        })
        mainView.addSubview(btn)
        btn.snp.makeConstraints({ (make) in
            make.left.equalTo(mainView).offset(((WIDTH - 40)/2) * CGFloat(i))
            make.bottom.equalTo(mainView)
            make.size.equalTo(CGSize(width:(WIDTH - 40)/2, height:30))
        })
    }
}



