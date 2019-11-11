//
//  UIApplication+Tracking.m
//  AFNetworking
//
//  Created by Khazan on 2019/8/9.
//

#import "UIApplication+Tracking.h"
#import "KZTrackingMacros.h"
#import "SwizzleManager.h"

@implementation UIApplication (Tracking)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    });
}


@end
