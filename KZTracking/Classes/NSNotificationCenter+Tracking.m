//
//  NSNotificationCenter+Tracking.m
//  AFNetworking
//
//  Created by Khazan on 2019/9/18.
//

#import "NSNotificationCenter+Tracking.h"
#import "SwizzleManager.h"
#import "KZTrackingMacros.h"
@implementation NSNotificationCenter (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(postNotification:) swizzledSelector:@selector(kz_postNotification:)];
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(postNotificationName:object:) swizzledSelector:@selector(kz_postNotificationName:object:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(postNotificationName:object:userInfo:) swizzledSelector:@selector(kz_postNotificationName:object:userInfo:)];
    });
}


#pragma mark - Method Swizzling

- (void)kz_postNotification:(NSNotification *)notification {
    [self kz_postNotification:notification];
    
    NSString *aName = [notification name];
    
    if (![self shouldShowLogWithName:aName]) {
        return;
    }
    
    TLOG(@"postNotification:%@", notification);
}

- (void)kz_postNotificationName:(NSNotificationName)aName object:(nullable id)anObject {
    [self kz_postNotificationName:aName object:anObject];
    
    if (![self shouldShowLogWithName:aName]) {
        return;
    }
    
    TLOG(@"postNotification name:%@ object:%@", aName, anObject);
}

- (void)kz_postNotificationName:(NSNotificationName)aName object:(nullable id)anObject userInfo:(nullable NSDictionary *)aUserInfo {
    [self kz_postNotificationName:aName object:anObject userInfo:aUserInfo];

    if (![self shouldShowLogWithName:aName]) {
        return;
    }
    
    TLOG(@"postNotification name:%@ object:%@ userInfo:%@", aName, anObject, aUserInfo);
}


- (BOOL)shouldShowLogWithName:(NSString *)name {
    // AFN
    if ([name isEqualToString:@"com.alamofire.networking.task.complete"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"com.alamofire.networking.task.resume"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"com.alamofire.networking.nsurlsessiontask.resume"]) {
        return NO;
    }
    
    // 时间改变
    if ([name isEqualToString:@"UIStatusBarTimeItemViewDidMoveNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"UIViewAnimationDidCommitNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"UIViewAnimationDidStopNotification"]) {
        return NO;
    }
    
    // 屏幕亮度改变
    if ([name isEqualToString:@"UIScreenBrightnessDidChangeNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"UIStatusBarItemViewShouldEndDisablingRasterizationNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"_UIAppearanceInvocationsDidChangeNotification"]) {
        return NO;
    }
    
    // 状态栏
    if ([name isEqualToString:@"_UIApplicationStatusBarHiddenStateChangedNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"_UIApplicationDidBeginIgnoringInteractionEventsNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"_UIApplicationDidEndIgnoringInteractionEventsNotification"]) {
        return NO;
    }
    
    if ([name isEqualToString:@"UITextEffectsWindowDidRotateNotification"]) {
        return NO;
    }
    
    // 方向改变
    if ([name isEqualToString:@"UIDeviceOrientationDidChangeNotification"]) {
        return NO;
    }
    // 点击屏幕
    if ([name isEqualToString:@"_UIWindowSystemGestureStateChangedNotification"]) {
        return NO;
    }
    // scrollview 滚动
    if ([name isEqualToString:@"_UIApplicationRunLoopModePushNotification"]) {
        return NO;
    }
    if ([name isEqualToString:@"_UIApplicationRunLoopModePopNotification"]) {
        return NO;
    }
    // 音量
    if ([name isEqualToString:@"_MPMediaRemotePickedRouteVolumeDidChangeNotification"]) {
        return NO;
    }
    if ([name isEqualToString:@"kMRMediaRemotePickedRouteVolumeDidChangeNotification"]) {
        return NO;
    }
    
    //
    if ([name hasPrefix:@"AVSystemController"]) {
        return NO;
    }
    if ([name hasPrefix:@"AVController"]) {
        return NO;
    }
    // NSUserDefault
    if ([name isEqualToString:@"NSUserDefaultsDidChangeNotification"]) {
        return NO;
    }
    
    // 过滤 textView
    if ([name hasPrefix:@"NSText"]) {
        return NO;
    }
    if ([name hasPrefix:@"_UIText"]) {
        return NO;
    }
    if ([name hasPrefix:@"UIText"]) {
        return NO;
    }
    if ([name hasPrefix:@"_UIScrollView"]) {
        return NO;
    }
    if ([name hasSuffix:@"SmoothScrolling"]) {
        return NO;
    }
    
    return YES;
}


@end
