//
//  ZyEncryption.swift
//  sk.charging_ios
//
//  Created by iosdev1 on 2017/9/25.
//  Copyright © 2017年 Zyy. All rights reserved.
//

import Foundation

//所有加密算法 汇总
extension String{
    //MARK: - sha1 加密
    func zy_sha1() -> String {
        //UnsafeRawPointer
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))

        let newData = NSData.init(data: data)
        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output as String
    }

    //MARK: - md5 加密
    func zy_md5() -> String {
        let cStr = self.cString(using: String.Encoding.utf8);
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
        CC_MD5(cStr!,(CC_LONG)(strlen(cStr!)), buffer)
        let md5String = NSMutableString();
        for i in 0 ..< 16{
            md5String.appendFormat("%02x", buffer[i])
        }
        free(buffer)
        return md5String as String
    }
}


//extension Int
//{
//    func hexedString() -> String
//    {
//        return NSString(format:"%02x", self) as String
//    }
//}
//
//extension NSData
//{
//    func hexedString() -> String
//    {
//        var string = String()
//        let unsafePointer = bytes.assumingMemoryBound(to: UInt8.self)
//        for i in UnsafeBufferPointer<UInt8>(start:unsafePointer, count: length)
//        {
//            string += Int(i).hexedString()
//        }
//        return string
//    }
//    func MD5() -> NSData
//    {
//        let result = NSMutableData(length: Int(CC_MD5_DIGEST_LENGTH))!
//        let unsafePointer = result.mutableBytes.assumingMemoryBound(to: UInt8.self)
//        CC_MD5(bytes, CC_LONG(length), UnsafeMutablePointer<UInt8>(unsafePointer))
//        return NSData(data: result as Data)
//    }
//}
//
//extension String
//{
//    func MD5() -> String
//    {
//        let data = (self as NSString).data(using: String.Encoding.utf8.rawValue)! as NSData
//        return data.MD5().hexedString()
//    }
//}
