//
//  UIControl+Tracking.m
//  KZTracking
//
//  Created by Khazan on 2019/8/2.
//

#import "UIControl+Tracking.h"
#import "KZTrackingMacros.h"
#import "SwizzleManager.h"

@implementation UIControl (Tracking)

+ (void)load {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(sendAction:to:forEvent:) swizzledSelector:@selector(kz_sendAction:to:forEvent:)];
        
    });
    
}

- (void)kz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    NSString *className = NSStringFromClass([target class]);
    
    if (![className hasPrefix:@"KZ"]) {
        TLOG(@"《target:::%@》 to do 《action:::%@》 for 《event:::%@》", target, NSStringFromSelector(action), event);
    }
    
    [self kz_sendAction:action to:target forEvent:event];
}

@end
