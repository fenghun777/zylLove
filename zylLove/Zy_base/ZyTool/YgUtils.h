//
// Created by caotian on 4/16/15.
// Copyright (c) 2015 ygsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "UMessage.h"
@class AFHTTPRequestOperation;

@interface YgUtils : NSObject

#pragma mark 根据宽等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image ByWidth:(float) width;

#pragma mark 等比压缩图片
+ (UIImage *)resizeImage:(UIImage *)image FromSize:(CGSize) size;

+ (CGSize)resizeSize:(CGSize)osize fromsize:(CGSize)size;

@end

