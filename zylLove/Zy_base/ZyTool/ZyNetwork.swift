//
//  ZyNetwork.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/13.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum HTTPRequestMethod {
    case OPTIONS
    case GET
    case HEAD
    case POST
    case PUT
    case PATCH
    case DELETE
    case TRACE
    case CONNECT
}

func httpRequest(method:HTTPRequestMethod,  url:String, parameters:Dictionary<String, Any>, error:Bool, SuccessClosure:@escaping (_ json:JSON)->Void,  FailClosure:@escaping (_ error:Error)->Void) -> Void {

    let netStatus = NetworkReachabilityManager.init()
    netStatus?.startListening()
    let status:NetworkReachabilityManager.NetworkReachabilityStatus = (netStatus?.networkReachabilityStatus)!
    switch status {
    case .unknown:
        echo(data: "未知的网络");
        break
    case .notReachable:
        echo(data: "网络中断");
        showMessage(message: "网络中断")
        break
    case .reachable(.ethernetOrWiFi):
        echo(data: "正在使用wifi");
        break
    case .reachable(.wwan):
        echo(data: "正在使用4g");
        break
    }

    var dicParameters:Parameters? = nil;
    dicParameters = zy_clientPrepareHttpParameters(dic: parameters)

    var urlStr:String = url

    var alamofireMethod:HTTPMethod = .post

    switch method {
    case .POST:
        alamofireMethod = .post;
        break
    case .GET:
        alamofireMethod = .get;
        urlStr = zy_clientPrepareHttpParametersToURL(dic: dicParameters!, url: urlStr)
        dicParameters = nil
        break
    case .PATCH:
        alamofireMethod = .patch;
        break
    case .PUT:
        alamofireMethod = .put;
    case .DELETE:
        alamofireMethod = .delete;
    case .HEAD:
        alamofireMethod = .head;
        break
    default:
        alamofireMethod = .options;
        break
    }

    let headers: HTTPHeaders = [
        "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        "Accept": "application/json",
    ]

    Alamofire.request(urlStr, method: alamofireMethod, parameters: dicParameters, encoding: JSONEncoding.default, headers: headers)
    .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { (progress) in
        echo(data: "打印进度:\(progress)");
    }
    .responseJSON { (response) in
        echo(data: "网址:\(String(describing: response.response?.url))")
        let statusCode = response.response?.statusCode
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            if statusCode == 200 {
                SuccessClosure(json)
            } else if statusCode == 201 {
                SuccessClosure(json)
            }else if statusCode == 202 {
                SuccessClosure(json)
            } else {
                showMessage(message: json["message"].stringValue);
            }
        case .failure(let error):
            echo(data: "失败:\(error)")
            FailClosure(error)
        }
        if statusCode != nil {
            getStatusCode(code: statusCode!)
        }
    }
}

func getStatusCode(code:Int) -> Void {
    let dicError = [
        200 : "正常",
        201 : "数据添加成功",
        204 : "操作成功",
        400 : "错误的请求",
        401 : "授权失效,需重新登录",
        403 : "没有权限",
        404 : "找不到内容，可能已删除",
        422 : "数据模型验证失败",
        500 : "服务器端错误"
    ]
    let iscontain = dicError.keys.contains { (element) -> Bool in
        if element == code {
            return true
        }else {
            return false
        }
    }
    if iscontain {
        echo(data: "\(code)==\(String(describing: dicError[code]))")
    }else{
        echo(data: "\(code)==未知的响应代码");
    }
    if code == 401 {
        let userdefaults:UserDefaults = UserDefaults.standard
        let appDomain = Bundle.main.bundleIdentifier
        userdefaults.removePersistentDomain(forName: appDomain!)
        //                设置 自动登录
        userdefaults.setValue(false, forKey: UD_isLogin)
        //重新调用appdelete 生成新的布局
        (UIApplication.shared.delegate as! ZyAppDelegate).signIn()
    }
}

//MARK:上传图片
func httpRequestUpload(urlString:String, image:UIImage, error:Bool, SuccessClosure:@escaping (_ json:JSON)->Void,  FailClosure:@escaping (_ error:Error)->Void) -> Void {
    let userdefault:UserDefaults = UserDefaults.standard
    let tokenStr:String = userdefault.object(forKey: UD_access_token) as! String
    let headers: HTTPHeaders = [
        "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        "Accept": "application/json",
        "access-token": tokenStr
    ]
    let imageData = UIImageJPEGRepresentation(image, 0.5)
//    let imageData = UIImagePNGRepresentation(image)
    Alamofire.upload(multipartFormData: { (multipartFormData) in
        //          data: 图片， name: 服务器接收文件的参数名（判断是哪一张图片）, fileName: 服务器获取到图片的名称， mimeType： 文件类型
        multipartFormData.append(imageData!, withName: "upfile", fileName: "zy_upfile", mimeType: "image")
    }, usingThreshold: 0, to: urlString, method: HTTPMethod.post, headers: headers) { (result) in
        switch result {
        case let .success(upload, _, _):
            upload.responseJSON(completionHandler: { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    echo(data: "网址:\(String(describing: response.response?.url))")
                    if statusCode == 200 {
                            SuccessClosure(json)
                    }else{
                        showMessage(message: json["message"].stringValue);
                    }
                case .failure(let error):
                    echo(data: "失败:\(error)")
                        FailClosure(error)
                }
                getStatusCode(code: statusCode!)
            })
        case .failure(let error):
            echo(data: "\(error)")
            break
        }
    }
}

//MARK:  上传录音
func httpRequestUploadSound(urlString:String, soundPath:String, error:Bool, SuccessClosure:@escaping (_ json:JSON)->Void,  FailClosure:@escaping (_ error:Error)->Void) -> Void {
    let userdefault:UserDefaults = UserDefaults.standard
    let tokenStr:String = userdefault.object(forKey: UD_access_token) as! String
    let headers: HTTPHeaders = [
        "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
        "Accept": "application/json",
        "access-token": tokenStr
    ]
//    let fileURL = Bundle.main.url(forResource: soundPath, withExtension: "mp3")
    let fileURL = NSURL.fileURL(withPath: soundPath)
    echo(data: "\(fileURL)")

    Alamofire.upload(multipartFormData: { (multipartFormData) in
        //          data: 图片， name: 服务器接收文件的参数名（判断是哪一张图片）, fileName: 服务器获取到图片的名称， mimeType： 文件类型
//        multipartFormData.append(fileURL, withName: "upfile", fileName: "zy_upfile", mimeType: "mp3")
        multipartFormData.append(fileURL, withName: "upfile", fileName: "zy_upfile.mp3", mimeType: "application/octet-stream")
    }, usingThreshold: 0, to: urlString, method: HTTPMethod.post, headers: headers) { (result) in
        switch result {
        case let .success(upload, _, _):
            upload.responseJSON(completionHandler: { (response) in
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    echo(data: "网址:\(String(describing: response.response?.url))")
                    if statusCode == 200 {
                        SuccessClosure(json)
                    }else{
                        showMessage(message: json["message"].stringValue);
                    }
                case .failure(let error):
                    echo(data: "失败:\(error)")
                    FailClosure(error)
                }
                getStatusCode(code: statusCode!)
            })
        case .failure(let error):
            echo(data: "\(error)")
            break
        }
    }

}



