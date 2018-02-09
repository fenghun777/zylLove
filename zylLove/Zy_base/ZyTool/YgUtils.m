//
//
// Created by caotian on 4/16/15.
// Copyright (c) 2015 ygsoft. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "YgUtils.h"

@interface YgUtils ()

@end

@implementation YgUtils {

}
#pragma mark 根据宽等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image ByWidth:(float) width{
    CGSize size = CGSizeMake(width, 0);    
    return [YgUtils resizeImage:image FromSize:size];
}

#pragma mark 等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image FromSize:(CGSize) size{
    if (!image) {
        return nil;
    }
    size = [self resizeSize:image.size fromsize:size];
    if (size.width == image.size.width) {
        return image;
    }
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(size);
    }
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

+ (CGSize)resizeSize:(CGSize)osize fromsize:(CGSize)size{
    float bl = MIN(size.width / osize.width, size.height / osize.height);
    if (bl == 0) {
        bl = MAX(size.width / osize.width, size.height / osize.height);
    }
    
    if (osize.width <= size.width && osize.height <= size.height) {
        return osize;
    }else{
        size.width = (int)(osize.width * bl * 100) / 100;
        size.height = (int)(osize.height * bl * 100) / 100;
    }
    return size;
}


//判断是否包含汉字
+ (BOOL)IsChinese:(NSString *)str{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

//把字符串中的汉字转化成utf8
+ (NSString *)chineseToUTF8:(NSString *)str{
    NSMutableString *muStr = (NSMutableString *)str;
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            NSString *chineseStr = [str substringWithRange:NSMakeRange(i, 1)];
            NSString *utfStr = [chineseStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            muStr = (NSMutableString *)[muStr stringByReplacingOccurrencesOfString:chineseStr withString:utfStr];
        }
    }
    return (NSString *)muStr;
}

+ (NSString *)sn:(NSString *)str{
    NSString *string;
    if (str) {
        string = str;
    }else{
        string = @"";
    }
    return string;
}

@end
