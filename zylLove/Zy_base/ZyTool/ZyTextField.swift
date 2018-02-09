
//
//  ZyTextField.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/21.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation



extension UITextField {

    class func initWithPlace(place:String, keyboard:UIKeyboardType, font:CGFloat,  returnClosure:@escaping (_ tfd:UITextField)->Void) -> UITextField {
        return initWithPlace(place: place, textColor: UIColor.black, secure: false, maxlength: 0, keyboard: keyboard, returnKeyType: UIReturnKeyType.done, font: font, clearButtonMode: UITextFieldViewMode.whileEditing, textAlignment: NSTextAlignment.left, returnClosure: returnClosure)
    }

    class func initWithPlace(place:String, textColor:UIColor, secure:Bool, maxlength:NSInteger, keyboard:UIKeyboardType, returnKeyType:UIReturnKeyType, font:CGFloat, clearButtonMode:UITextFieldViewMode, textAlignment:NSTextAlignment,  returnClosure:@escaping (_ tfd:UITextField)->Void) -> UITextField {

        let tfd = UITextField.init()
        tfd.placeholder = place//            设置提示文本
        tfd.keyboardType = keyboard//            键盘样式
        tfd.isSecureTextEntry = secure //每输入一个字符就变成点 用语密码输入
        tfd.textColor = textColor //设置字体颜色
        tfd.returnKeyType = returnKeyType//设置返回样式 return键变成什么键,要显示中文,还得设置info.plist中 Localization native development region 为 cn
        tfd.font = UIFont.init(name: "Arial", size: font) //设置输入框内容的字体样式和大小
        tfd.adjustsFontSizeToFitWidth = false//设置为true时文本会自动缩小以适应文本窗口大小.默认是保持原来大小,而让长文本滚动
        tfd.minimumFontSize = 10.0//设置自动缩小显示的最小字体大小
        tfd.borderStyle = UITextBorderStyle.none//设置边框样式，只有设置了才会显示边框样式,这种会遮盖背景图片，line的设置背景图片才有效
        tfd.autocorrectionType = UITextAutocorrectionType.no//是否纠错
        tfd.clearButtonMode = clearButtonMode //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
        tfd.clearsOnBeginEditing = false//再次编辑就清空
        tfd.textAlignment = textAlignment//内容对齐方式
        tfd.contentVerticalAlignment = UIControlContentVerticalAlignment.center//内容的垂直对齐方式 UITextField继承自UIControl,此类中有一个属性
        tfd.autocapitalizationType = UITextAutocapitalizationType.none//首字母是否大写
        tfd.keyboardAppearance = UIKeyboardAppearance.dark//键盘外观

        if maxlength > 0 {
            tfd.bk_shouldChangeCharactersInRangeWithReplacementStringBlock = {(textfield:UITextField?, range:NSRange?, str:String?) -> Bool in
                let result:Bool = (textfield?.text?.lengthOfBytes(using: String.Encoding.utf8))! <= maxlength - 1 || (str?.isEmpty)!
                return result;
            }
        }

        tfd.bk_shouldReturnBlock = {(textfield)in
            textfield?.resignFirstResponder()
            return true
        }

        tfd.bk_didEndEditingBlock = {(textfield)in
            returnClosure(textfield!)
        }
        return tfd;
    }
}
