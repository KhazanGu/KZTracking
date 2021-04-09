//
//  KZTracking.h
//  KZTracking
//
//  Created by Khazan on 4/9/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KZTracking : NSObject

@property (nonatomic, copy) NSArray *ignoreURLs;

+ (KZTracking *)sharedInstance;

@end

NS_ASSUME_NONNULL_END
