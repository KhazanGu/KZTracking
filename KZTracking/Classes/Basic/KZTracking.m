//
//  KZTracking.m
//  KZTracking
//
//  Created by Khazan on 4/9/21.
//

#import "KZTracking.h"

@interface KZTracking ()

@end

@implementation KZTracking

+ (KZTracking *)sharedInstance {
    static KZTracking *tracking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tracking = [[KZTracking alloc] init];
    });
    return tracking;
}






@end
