//
//  ZyUIImage.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/10/12.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

extension UIImage {

//    获取网络图片
    class func initUrl(urlStr:String) -> UIImage {
        var imageStr:String = urlStr
        if (!imageStr.contains("http:")) {
            imageStr = API_HOST_IMAGE + imageStr
        }
        let url = URL(string: imageStr)
        var image:UIImage = UIImage.init()
        do {
            let data:Data = try Data.init(contentsOf: url!, options: Data.ReadingOptions.uncached)
            image = UIImage.init(data: data)!
        } catch {

        }
        return image
    }

//    图片压缩
    func zy_resizeImage(sizeTo:CGSize ) -> UIImage {
        let size:CGSize = zy_resizeSize(osize: self.size, sizeTo: sizeTo)
        if size.width == self.size.width {
            return self
        }
        // 创建一个bitmap的context
        // 并把它设置成为当前正在使用的context
        UIGraphicsBeginImageContext(size);
// 绘制改变大小的图片
        self.draw(in: CGRect(x:0, y:0, width:size.width, height:size.height))
// 从当前context中创建一个改变大小后的图片
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        // 使当前的context出堆栈
        UIGraphicsEndImageContext()
        return scaledImage!
    }


}
