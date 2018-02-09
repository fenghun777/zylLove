//
//  ZyBaseModel.swift
//  Swiftframe
//
//  Created by iosdev1 on 2017/9/14.
//  Copyright © 2017年 Zyy. All rights reserved.
//NSUD_TOKEN

import Foundation
import ObjectMapper

//MARK: 模板
class ZyBaseModel: Mappable {
//    var check_id: NSInteger?//后台返回什么类型就就写成什么类型，不然无法赋值
//    var CLASS: String?//关键字 改成大写
//    var age: Int?
//    var weight: Double!
//    var bestFriend: User?        // User对象
//    var friends: [User]?         // Users数组
//    var birthday: Date?
//    var array: [AnyObject]?
//    var dictionary: [String : AnyObject] = [:]
    init(){}
    required init?(map: Map) {}
    // Mappable
    func mapping(map: Map) {
//        check_id    <- map["check_id"]
//        CLASS    <- map["class"]
//        age         <- map["age"]
//        weight      <- map["weight"]
//        bestFriend  <- map["best_friend"]
//        friends     <- map["friends"]
//        birthday    <- (map["birthday"], DateTransform())
//        array       <- map["arr"]
//        dictionary  <- map["dict"]
    }
}

//MARK:所有带有分页刷新的数据，通用该model (特指返回数据用items封装过的)
class ItemsModel: ZyBaseModel {
    var items:Array<Dictionary<String, Any>>?
    var _links:Dictionary<String, Any>?
    var _meta:Dictionary<String, Any>?

    // Mappable
    override func mapping(map: Map) {
        items    <- map["items"]
        _links    <- map["_links"]
        _meta    <- map["_meta"]
    }
}

// MARK:客户注册/登陆
class LoginModel: ZyBaseModel {
    var name:String?
    var profession:String?
    var updated_at:NSInteger?
    var credit:NSInteger?
    var mobile:String?
    var age:NSInteger?
    var access_token:String?
    var pic:String?
    var status:NSInteger?
    var balance:String?
    var id:NSInteger?
    var created_at:NSInteger?
    var company:String?
    var sex:NSInteger?
    var trade:String?

    // Mappable
    override func mapping(map: Map) {
        name    <- map["name"]
        profession    <- map["profession"]
        updated_at    <- map["updated_at"]
        credit    <- map["credit"]
        mobile    <- map["mobile"]
        age    <- map["age"]
        access_token    <- map["access_token"]
        pic    <- map["pic"]
        status    <- map["status"]
        balance    <- map["balance"]
        id    <- map["id"]
        created_at    <- map["created_at"]
        company    <- map["company"]
        sex    <- map["sex"]
        trade    <- map["trade"]
    }
}

//MARK:验证码
class GetCaptchaModel: ZyBaseModel {
    var check_id:NSInteger?
    // Mappable
    override func mapping(map: Map) {
        check_id    <- map["check_id"]
    }
}

//MARK:验证码的check_id
class GeteeCaptchaModel: ZyBaseModel {
    var check_id:NSInteger?
    var _class:String?
    // Mappable
    override func mapping(map: Map) {
        check_id    <- map["check_id"]
        _class    <- map["class"]
    }
}

//MARK: 退出登陆
class LogoutModel: ZyBaseModel {
    // Mappable
    override func mapping(map: Map) {
//        check_id    <- map["check_id"]
    }
}

//MARK: 验证码列表
class MesListModel: ZyBaseModel {
    var items:Array<Dictionary<String, Any>>?

    // Mappable
    override func mapping(map: Map) {
        items    <- map["items"]
    }
}

//MARK:网点列表
class OrderNetworkListModel: ZyBaseModel {
    var id:String?
    var name:String?
    var node_id:String?
    var parent_id:String?
    var charger_code:String?
    var charger_username:String?
    var charger_password:String?
    var license:String?
    var employee_id:String?
    var lon:String?
    var lat:String?
    var status:String?
    var created_at:String?
    var updated_at:String?
    var distance:Double?
    var node:Dictionary<String, Any>?
    var employee:Dictionary<String, Any>?
    var queue_num:NSInteger?
    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        name    <- map["name"]
        node_id    <- map["node_id"]
        parent_id    <- map["parent_id"]
        charger_code    <- map["charger_code"]
        charger_username    <- map["charger_username"]
        charger_password    <- map["charger_password"]
        license    <- map["license"]
        employee_id    <- map["employee_id"]
        lon    <- map["lon"]
        lat    <- map["lat"]
        status    <- map["status"]
        created_at    <- map["created_at"]
        updated_at    <- map["updated_at"]
        distance    <- map["distance"]
        node    <- map["node"]
        employee    <- map["employee"]
        queue_num    <- map["queue_num"]
    }
}

//MARK:汽车详情
class CarInfoModel: ZyBaseModel {
    var id:NSInteger?
    var user_id:NSInteger?
    var brand:String?
    var pic:String?
    var model:String?
    var color:String?
    var license:String?
    var vin:String?
    var vip:NSInteger?
    var tag:String?
    var _default:NSInteger?
    var recharging_count:NSInteger?

    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        user_id    <- map["user_id"]
        brand    <- map["brand"]
        pic    <- map["pic"]
        model    <- map["model"]
        color    <- map["color"]
        license    <- map["license"]
        vin    <- map["vin"]
        vip    <- map["vip"]
        tag    <- map["tag"]
        _default    <- map["default"]
        recharging_count    <- map["recharging_count"]
    }
}

//MARK:牌照详情
class BandInfoModel: ZyBaseModel {
    var id:NSInteger?
    var band:String?
    var model:Array<Any>?

    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        band    <- map["band"]
        model    <- map["model"]
    }
}

//MARK:上传图片返回数据
class UploadImageModel: ZyBaseModel {
    var url:String?
    var cloud_key:String?
    // Mappable
    override func mapping(map: Map) {
        url    <- map["url"]
        cloud_key    <- map["cloud_key"]
    }
}

//MARK:订单详情
class OrderInfoModel: ZyBaseModel {
    var id:String?
    var category:NSInteger?
    var user_id:NSInteger?
    var brand:String?
    var model:String?
    var car_pic:String?
    var license:String?
    var color:String?
    var vip:NSInteger?
    var tag:String?
    var lon:String?
    var lat:String?
    var address:String?
    var pic:String?
    var voice:String?
    var service_time:NSInteger?
    var service_before_time:NSInteger?
    var node_id:NSInteger?
    var node_name:String?
    var service_car_id:NSInteger?
    var charger_code:String?
    var employee_id:NSInteger?
    var employee_name:String?
    var employee_mobile:String?
    var employee_pic:String?
    var charging_seq:String?
    var dispatch_time:NSInteger?
    var go_time:NSInteger?
    var start_time:NSInteger?
    var end_time:NSInteger?
    var unit_price:String?
    var degree:String?
    var total_o:String?
    var total:String?
    var pay_method:NSInteger?
    var status:NSInteger?
    var created_at:NSInteger?
    var updated_at:NSInteger?
    var node:Dictionary<String, Any>?
    var distance:Double?
    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        category    <- map["category"]
        user_id    <- map["user_id"]
        brand    <- map["brand"]
        model    <- map["model"]
        car_pic    <- map["car_pic"]
        license    <- map["license"]
        color    <- map["color"]
        vip    <- map["vip"]
        tag    <- map["tag"]
        lon    <- map["lon"]
        lat    <- map["lat"]
        address    <- map["address"]
        pic    <- map["pic"]
        voice    <- map["voice"]
        service_time    <- map["service_time"]
        service_before_time    <- map["service_before_time"]
        node_id    <- map["node_id"]
        node_name    <- map["node_name"]
        service_car_id    <- map["service_car_id"]
        charger_code    <- map["charger_code"]
        employee_id    <- map["employee_id"]
        employee_name    <- map["employee_name"]
        employee_mobile    <- map["employee_mobile"]
        employee_pic    <- map["employee_pic"]
        charging_seq    <- map["charging_seq"]
        dispatch_time    <- map["dispatch_time"]
        go_time    <- map["go_time"]
        start_time    <- map["start_time"]
        end_time    <- map["end_time"]
        unit_price    <- map["unit_price"]
        degree    <- map["degree"]
        total_o    <- map["total_o"]
        total    <- map["total"]
        pay_method    <- map["pay_method"]
        status    <- map["status"]
        created_at    <- map["created_at"]
        updated_at    <- map["updated_at"]
        node    <- map["node"]
        distance    <- map["distance"]
    }
}
//MARK:获取实时充电数据
class ChargingInfoModel: ZyBaseModel {
    var charging_rate:String?
    var output_voltage:String?
    var output_electric:String?
    var charging_volume:String?
    var price:String?
    var order_status:NSInteger?
    // Mappable
    override func mapping(map: Map) {
        charging_rate    <- map["charging_rate"]
        output_voltage    <- map["output_voltage"]
        output_electric    <- map["output_electric"]
        charging_volume    <- map["charging_volume"]
        price    <- map["price"]
        order_status    <- map["order_status"]
    }
}
//MARK: 冷链商城商品
class ProductModel: ZyBaseModel {
    var id:NSInteger?
    var title:String?
    var pic:String?
    var spec:String?
    var price:String?
    var storage:String?
    var home:String?
    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        title    <- map["title"]
        pic    <- map["pic"]
        spec    <- map["spec"]
        price    <- map["price"]
        storage    <- map["storage"]
        home    <- map["home"]
    }
}

//MARK: 冷链商城订单
class ProductOrderInfoModel: ZyBaseModel {
    var id:String?
    var user_id:NSInteger?
    var product_id:NSInteger?
    var title:String?
    var pic:String?
    var spec:String?
    var unit_price:String?
    var count:NSInteger?
    var total_price:String?
    var express_name:String?
    var express_type:NSInteger?
    var status:NSInteger?
    var created_at:NSInteger?
    // Mappable
    override func mapping(map: Map) {
        id    <- map["id"]
        user_id    <- map["user_id"]
        product_id    <- map["product_id"]
        title    <- map["title"]
        pic    <- map["pic"]
        spec    <- map["spec"]
        unit_price    <- map["unit_price"]
        count    <- map["count"]
        total_price    <- map["total_price"]
        express_name    <- map["express_name"]
        express_type    <- map["express_type"]
        status    <- map["status"]
        created_at    <- map["created_at"]
    }
}

//MARK:支付宝
class OrderAlipayModel: ZyBaseModel {
    var sdk:String?
    // Mappable
    override func mapping(map: Map) {
        sdk    <- map["sdk"]
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

//MARK:

//MARK:

//MARK:
//MARK:

//MARK:

//MARK:

//MARK:

//MARK:

//MARK:
