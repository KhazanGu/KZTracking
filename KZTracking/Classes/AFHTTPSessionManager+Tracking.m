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

@implementation AFHTTPSessionManager (Tracking)

- (void)addLogWithURL:(NSString *)url parameters:(NSDictionary *)parameters task:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error requestTime:(double)requestTime {
    NSURLRequest *request = [task currentRequest];
    NSString *method = request.HTTPMethod;
    NSDictionary *headerFields = [request allHTTPHeaderFields];
    
    double timeout = request.timeoutInterval;
    double interval = [[NSDate date] timeIntervalSince1970] - requestTime;
    id responseBody = [self objectWithresponseObject:responseObject];
    
    NSString *logging;
    if (error) {
        logging = [NSString stringWithFormat:@"request <<<===\nurl:%@\nmethod:%@  timeout:%f  times:%f\nheaderFields:%@\nparameters:%@\nerror:%@\nrequest ===>>>", url, method, timeout, interval, headerFields, parameters, error];
    } else {
        logging = [NSString stringWithFormat:@"request <<<===\nurl:%@\nmethod:%@  timeout:%f  times:%f\nheaderFields:%@\nparameters:%@\nresponse:%@\nrequest ===>>>", url, method, timeout, interval, headerFields, parameters, responseBody];
    }
    
    TLOG(@"%@", logging);
}

- (id)objectWithresponseObject:(id)responseObject {
    if (responseObject == nil) {
        return nil;
    }
    
    if (![responseObject isKindOfClass:[NSData class]]) {
        return responseObject;
    }
    
    NSError *json_error;
    id obj = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&json_error];
    if (json_error) {
        obj = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    }
    return obj;
}


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_GET:parameters:headers:success:failure:) swizzledSelector:@selector(GET:parameters:headers:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_GET:parameters:headers:progress:success:failure:) swizzledSelector:@selector(GET:parameters:headers:progress:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_HEAD:parameters:headers:success:failure:) swizzledSelector:@selector(HEAD:parameters:headers:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:success:failure:) swizzledSelector:@selector(POST:parameters:headers:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:progress:success:failure:) swizzledSelector:@selector(POST:parameters:headers:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:constructingBodyWithBlock:success:failure:) swizzledSelector:@selector(POST:parameters:headers:constructingBodyWithBlock:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_POST:parameters:headers:constructingBodyWithBlock:progress:success:failure:) swizzledSelector:@selector(POST:parameters:headers:constructingBodyWithBlock:progress:success:failure:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PUT:parameters:headers:success:failure:) swizzledSelector:@selector(PUT:parameters:headers:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_PATCH:parameters:headers:success:failure:) swizzledSelector:@selector(PATCH:parameters:headers:success:failure:)];

        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(kz_DELETE:parameters:headers:success:failure:) swizzledSelector:@selector(DELETE:parameters:headers:success:failure:)];
        
    });
}




- (nullable NSURLSessionDataTask *)kz_GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                                  headers:(NSDictionary *)headers
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_GET:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
    
}


- (nullable NSURLSessionDataTask *)kz_GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                                  headers:(NSDictionary *)headers
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_GET:URLString parameters:parameters headers:headers progress:downloadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
    
}


- (nullable NSURLSessionDataTask *)kz_HEAD:(NSString *)URLString
                             parameters:(nullable id)parameters
                                   headers:(NSDictionary *)headers
                                success:(nullable void (^)(NSURLSessionDataTask *task))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_HEAD:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:nil requestTime:requestTime];
        success ? success(task) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                   headers:(NSDictionary *)headers
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_POST:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                   headers:(NSDictionary *)headers
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_POST:URLString parameters:parameters headers:headers progress:uploadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                   headers:(NSDictionary *)headers
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure DEPRECATED_ATTRIBUTE {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_POST:URLString parameters:parameters headers:headers constructingBodyWithBlock:block success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}

- (nullable NSURLSessionDataTask *)kz_POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                   headers:(NSDictionary *)headers
              constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_POST:URLString parameters:parameters headers:headers constructingBodyWithBlock:block progress:uploadProgress success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_PUT:(NSString *)URLString
                            parameters:(nullable id)parameters
                                  headers:(NSDictionary *)headers
                               success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                               failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_PUT:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}


- (nullable NSURLSessionDataTask *)kz_PATCH:(NSString *)URLString
                              parameters:(nullable id)parameters
                                    headers:(NSDictionary *)headers
                                 success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                 failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_PATCH:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}

- (nullable NSURLSessionDataTask *)kz_DELETE:(NSString *)URLString
                               parameters:(nullable id)parameters
                                     headers:(NSDictionary *)headers
                                  success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                  failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    return [self kz_DELETE:URLString parameters:parameters headers:headers success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:responseObject error:nil requestTime:requestTime];
        success ? success(task, responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
        [self addLogWithURL:URLString parameters:parameters task:task responseObject:nil error:error requestTime:requestTime];
        failure ? failure(task, error) : nil;
    }];
}

@end
