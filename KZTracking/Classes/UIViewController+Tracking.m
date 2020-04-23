//
//  UIViewController+Tracking.m
//  KZTracking
//
//  Created by Khazan on 2019/8/2.
//

#import "UIViewController+Tracking.h"
#import "KZTrackingMacros.h"
#import "SwizzleManager.h"

@implementation UIViewController (Tracking)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(viewDidLoad) swizzledSelector:@selector(kz_viewDidLoad)];
        [SwizzleManager swizzledWithClass:[self class] originalSelector:NSSelectorFromString(@"dealloc") swizzledSelector:@selector(kz_dealloc)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(viewDidAppear:) swizzledSelector:@selector(kz_viewDidAppear:)];
        
    });
}


#pragma mark - Method Swizzling
int activityControllers = 0;
- (void)kz_viewDidLoad {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"KZ"]) {
        activityControllers += 1;
        TLOG(@"%@ view did load, activity controllers: %d", NSStringFromClass([self class]), activityControllers);
    }
    
    [self kz_viewDidLoad];
}

- (void)kz_viewDidAppear:(BOOL)animated {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"KZ"]) {
        TLOG(@"%@ view did appear", NSStringFromClass([self class]));
    }
    
    [self kz_viewDidAppear:animated];
}


- (void)kz_dealloc {
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"KZ"]) {
        activityControllers -= 1;
        TLOG(@"%@ dealloc, activity controllers: %d", NSStringFromClass([self class]), activityControllers);
    }
    
    [self kz_dealloc];
}

@end
