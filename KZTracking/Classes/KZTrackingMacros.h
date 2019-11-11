//
//  KZTrackingMacros.h
//  Pods
//
//  Created by Khazan on 2019/8/2.
//

#ifndef KZTrackingMacros_h
#define KZTrackingMacros_h

#define TLOG(format, ...) printf("tracking >>> %s %s\n", [[[NSDate date] description] UTF8String], [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String]);

#endif /* KZTrackingMacros_h */
