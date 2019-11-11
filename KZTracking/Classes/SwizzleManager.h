//
//  SwizzleManager.h
//  AFNetworking
//
//  Created by Khazan on 2019/8/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwizzleManager : NSObject

+ (void)swizzledWithClass:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
