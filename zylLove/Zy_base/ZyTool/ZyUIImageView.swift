//
//  ZyUIImageView.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/10/11.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {

//    设置网络图片
    func zy_SetImage(urlStr:String, placeholder:String) -> Void {        
        var imageStr:String = urlStr
        if (!imageStr.contains("http:")) {
            imageStr = API_HOST_IMAGE + imageStr
        }
        let url = URL(string: imageStr)

        self.kf.setImage(with: url, placeholder: UIImage.init(named: placeholder), options: [.transition(ImageTransition.fade(1))], progressBlock: { (intOne, intTwo) in
//            echo(data: "=====intOne:\(intOne)")
//            echo(data: "=====intTwo:\(intTwo)")
        }) { (image, error, cachetype, url) in
//            echo(data: "=====image:\(image)")
//            echo(data: "=====error:\(error)")
//            echo(data: "=====cachetype:\(cachetype)")
//            echo(data: "=====url:\(url)")
        }
    }


}
