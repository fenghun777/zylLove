//
//  ZyApi.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/14.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper


func getCompleteUrl(key:String) -> String {

    let dic:Dictionary<String, String> = [
        "upload_upload_image":"/upload/upload-image",//上传图片接口地址：/upload/upload-image 上传图片参数名称"upfile" 返回：{'cloud_key':'云存储key','url'=>'图片完整地址'}
        "upload_upload_file":"/upload/upload-file",//上传录音接口地址：/upload/upload-file 上传文件参数名称"upfile" 返回：{'cloud_key':'云存储key','url'=>'文件完整地址'}

        "auth_login":"/auth/login",//客户注册/登陆
        "auth_get_captcha":"/auth/get-captcha",//获取验证码
        "auth_logout":"/auth/logout",//退出登陆
        "auth_mes":"/auth/mes",//验证码列表
    ]
    return API_HOST_API + dic[key]!;
}

// MARK: 上传图片
func api_uploadUploadImage(image:UIImage, SuccessClosure:@escaping (_ model:UploadImageModel)->Void,  FailClosure:@escaping (_ error:Error)->Void) -> Void {
    let url:String! = getCompleteUrl(key: "upload_upload_image")
//    let imageSource:UIImage = imageSource.zy_resizeImage(sizeTo: CGSize(width:WIDTH, height:0))
    let imageSource:UIImage = YgUtils.resize(image, byWidth: Float(UIScreen.main.bounds.size.width))
    httpRequestUpload(urlString: url, image: imageSource, error: true, SuccessClosure: { (json) in
        let modelUI:UploadImageModel = UploadImageModel(JSON: json.dictionaryObject!)!
        SuccessClosure(modelUI)
    }) { (error) in
        FailClosure(error)
    }
}

//MARK: 上传录音
func api_uploadUploadSound(soundStr:String, SuccessClosure:@escaping (_ model:UploadImageModel)->Void,  FailClosure:@escaping (_ error:Error)->Void) -> Void {
    let url:String! = getCompleteUrl(key: "upload_upload_file")
    httpRequestUploadSound(urlString: url, soundPath: soundStr, error: true, SuccessClosure: { (json) in
        let modelUI:UploadImageModel = UploadImageModel(JSON: json.dictionaryObject!)!
        SuccessClosure(modelUI)
    }) { (error) in
        FailClosure(error)
    }
}

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK: 

//MARK:
