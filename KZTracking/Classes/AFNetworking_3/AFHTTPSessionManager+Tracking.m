//
//  AFHTTPSessionManager+Tracking.m
//  AFNetworking
//
//  Created by Khazan on 2019/8/2.
//

#import "AFHTTPSessionManager+Tracking.h"
#import <objc/runtime.h>
#import "SwizzleManager.h"
#import "KZTrackingMacros.h"
#import "KZTracking.h"
#import <AFNetworking/AFNetworking.h>

@implementation AFHTTPSessionManager (Tracking)

- (void)formatLogWithURL:(NSString *)url
                  method:(NSString *)method
              parameters:(NSDictionary *)parameters
          responseObject:(id)responseObject
                   error:(NSError *)error
             requestTime:(double)requestTime {
    
    NSArray *igs = [[KZTracking sharedInstance] ignoreURLs];
    
    __block BOOL ignore;
    
    [igs enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([url hasPrefix:obj]) {
            ignore = YES;
            *stop = YES;
        }
    }];
    
    if (ignore) {
        return;
    }
    
    NSDictionary *headers = self.requestSerializer.HTTPRequestHeaders;
    
    NSDate *atTime = [NSDate dateWithTimeIntervalSince1970:requestTime];
    double interval = [[NSDate date] timeIntervalSince1970] - requestTime;
    
    NSString *logging;
    
    if (error) {
        
        logging = [NSString stringWithFormat:@"NSURLSession <<<===\nurl:%@\natTime:%@ interval:%f\nmethod:%@\nheaderFields:%@\nparameters:%@\nerror:%@\nNSURLSession ===>>>", url, atTime, interval, method, headers, parameters, error];
        
    } else {
        
        id response = [self objectWithresponseObject:responseObject];
        
        logging = [NSString stringWithFormat:@"NSURLSession <<<===\nurl:%@\natTime:%@ interval:%f\nmethod:%@\nheaderFields:%@\nparameters:%@\nresponse:%@\nNSURLSession ===>>>", url, atTime, interval, method, headers, parameters, response];
    }
    
    TLOG(@"%@", logging);
}

- (id)objectWithresponseObject:(id)responseObject {
    
    if (responseObject == nil) {
        return nil;
    }
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    
    return responseObject;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_GET:parameters:success:failure:) swizzledSelector:@selector(GET:parameters:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_GET:parameters:progress:success:failure:) swizzledSelector:@selector(GET:parameters:progress:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_HEAD:parameters:success:failure:) swizzledSelector:@selector(HEAD:parameters:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:success:failure:) swizzledSelector:@selector(POST:parameters:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:progress:success:failure:) swizzledSelector:@selector(POST:parameters:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:constructingBodyWithBlock:success:failure:) swizzledSelector:@selector(POST:parameters:constructingBodyWithBlock:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:constructingBodyWithBlock:progress:success:failure:) swizzledSelector:@selector(POST:parameters:constructingBodyWithBlock:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PUT:parameters:success:failure:) swizzledSelector:@selector(PUT:parameters:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PATCH:parameters:success:failure:) swizzledSelector:@selector(PATCH:parameters:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_DELETE:parameters:success:failure:) swizzledSelector:@selector(DELETE:parameters:success:failure:)];
        
    });
}


- (nullable NSURLSessionDataTask *)kz_GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_GET:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"GET" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"GET" parameters:parameters responseObject:nil error:error requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
    }];
    
}


- (nullable NSURLSessionDataTask *)kz_GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_GET:URLString parameters:parameters progress:downloadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"GET" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"GET" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_HEAD:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask *task) {
        
        [self formatLogWithURL:URLString method:@"HEAD" parameters:parameters responseObject:nil error:nil requestTime:requestTime];
        
        success ? success(task) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"HEAD" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}

- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"POST" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_PUT:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_PUT:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"PUT" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"PUT" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_PATCH:(NSString *)URLString
                              parameters:(nullable id)parameters
                                 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"PATCH" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"PATCH" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}

- (nullable NSURLSessionDataTask *)kz_DELETE:(NSString *)URLString
                               parameters:(nullable id)parameters
                                  success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString method:@"DELETE" parameters:parameters responseObject:responseObject error:nil requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString method:@"DELETE" parameters:parameters responseObject:nil error:error requestTime:requestTime];

        failure ? failure(task, error) : nil;
    }];
}

@end
