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

@implementation AFHTTPSessionManager (Tracking)

- (void)formatLogWithURL:(NSString *)url
                  method:(NSString *)method
              parameters:(NSDictionary *)parameters
                 headers:(NSDictionary<NSString *,NSString *> *)headers
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
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_GET:parameters:headers:progress:success:failure:) swizzledSelector:@selector(GET:parameters:headers:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_HEAD:parameters:headers:success:failure:) swizzledSelector:@selector(HEAD:parameters:headers:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:progress:success:failure:) swizzledSelector:@selector(POST:parameters:headers:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:constructingBodyWithBlock:progress:success:failure:) swizzledSelector:@selector(POST:parameters:headers:constructingBodyWithBlock:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PUT:parameters:headers:success:failure:) swizzledSelector:@selector(PUT:parameters:headers:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PATCH:parameters:headers:success:failure:) swizzledSelector:@selector(PATCH:parameters:headers:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_DELETE:parameters:headers:success:failure:) swizzledSelector:@selector(DELETE:parameters:headers:success:failure:)];
        
    });
}


- (NSURLSessionDataTask *)kz_GET:(NSString *)URLString
                      parameters:(id)parameters
                         headers:(NSDictionary<NSString *,NSString *> *)headers
                        progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                         success:(void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return  [self kz_GET:URLString
              parameters:parameters
                 headers:headers
                progress:downloadProgress
                 success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"GET"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self formatLogWithURL:URLString
                        method:@"GET"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}


- (NSURLSessionDataTask *)kz_HEAD:(NSString *)URLString
                       parameters:(id)parameters
                          headers:(NSDictionary<NSString *,NSString *> *)headers
                          success:(void (^)(NSURLSessionDataTask * _Nonnull))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return  [self kz_HEAD:URLString
               parameters:parameters
                  headers:headers
                  success:^(NSURLSessionDataTask * _Nonnull task) {
        
        [self formatLogWithURL:URLString
                        method:@"HEAD"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task) : nil;
        
    }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self formatLogWithURL:URLString
                        method:@"HEAD"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}


- (NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                       parameters:(id)parameters
                          headers:(NSDictionary<NSString *,NSString *> *)headers
                         progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                          success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString
              parameters:parameters
                 headers:headers
                progress:uploadProgress
                 success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"POST"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString
                        method:@"POST"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}


- (NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                       parameters:(id)parameters
                          headers:(NSDictionary<NSString *,NSString *> *)headers
        constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block
                         progress:(void (^)(NSProgress * _Nonnull))uploadProgress
                          success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                          failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_POST:URLString
              parameters:parameters
                 headers:headers
constructingBodyWithBlock:block
                progress:uploadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"POST"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        
        [self formatLogWithURL:URLString
                        method:@"POST"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}


- (NSURLSessionDataTask *)kz_PUT:(NSString *)URLString
                      parameters:(id)parameters
                         headers:(NSDictionary<NSString *,NSString *> *)headers
                         success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                         failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_PUT:URLString
             parameters:parameters
                headers:headers
                success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"PUT"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self formatLogWithURL:URLString
                        method:@"PUT"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
}


- (NSURLSessionDataTask *)kz_PATCH:(NSString *)URLString
                        parameters:(id)parameters
                           headers:(NSDictionary<NSString *,NSString *> *)headers
                           success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                           failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_PATCH:URLString
               parameters:parameters
                  headers:headers
                  success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"PATCH"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self formatLogWithURL:URLString
                        method:@"PATCH"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}

- (NSURLSessionDataTask *)kz_DELETE:(NSString *)URLString
                         parameters:(id)parameters
                            headers:(NSDictionary<NSString *,NSString *> *)headers
                            success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                            failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    return [self kz_DELETE:URLString
                parameters:parameters
                   headers:headers
                   success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        
        [self formatLogWithURL:URLString
                        method:@"DELETE"
                    parameters:parameters
                       headers:headers
                responseObject:responseObject
                         error:nil
                   requestTime:requestTime];
        
        success ? success(task, responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self formatLogWithURL:URLString
                        method:@"DELETE"
                    parameters:parameters
                       headers:headers
                responseObject:nil
                         error:error
                   requestTime:requestTime];
        
        failure ? failure(task, error) : nil;
        
    }];
    
}

@end
