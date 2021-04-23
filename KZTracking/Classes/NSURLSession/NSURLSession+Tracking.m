//
//  NSURLSession+Tracking.m
//  AFNetworking
//
//  Created by Khazan on 2019/11/12.
//

#import "NSURLSession+Tracking.h"
#import "KZTrackingMacros.h"
#import "SwizzleManager.h"
#import "KZTracking.h"

@implementation NSURLSession (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(dataTaskWithRequest:completionHandler:) swizzledSelector:@selector(kz_dataTaskWithRequest:completionHandler:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(dataTaskWithURL:completionHandler:) swizzledSelector:@selector(kz_dataTaskWithURL:completionHandler:)];
        
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(uploadTaskWithRequest:fromFile:completionHandler:) swizzledSelector:@selector(kz_uploadTaskWithRequest:fromFile:completionHandler:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(uploadTaskWithRequest:fromData:completionHandler:) swizzledSelector:@selector(kz_uploadTaskWithRequest:fromData:completionHandler:)];
        
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(downloadTaskWithRequest:completionHandler:) swizzledSelector:@selector(kz_downloadTaskWithRequest:completionHandler:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(downloadTaskWithURL:completionHandler:) swizzledSelector:@selector(kz_downloadTaskWithURL:completionHandler:)];
        
        [SwizzleManager swizzledWithClass:[self class] originalSelector:@selector(downloadTaskWithResumeData:completionHandler:) swizzledSelector:@selector(kz_downloadTaskWithResumeData:completionHandler:)];
    });
}


- (NSURLSessionDataTask *)kz_dataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self kz_dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        [self addLogWithURLRequest:request data:data response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)kz_dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self kz_dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        [self addLogWithURL:url data:data response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

/*
 * upload convenience method.
 */
- (NSURLSessionUploadTask *)kz_uploadTaskWithRequest:(NSURLRequest *)request fromFile:(NSURL *)fileURL completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionUploadTask *dataTask = nil;
    
    dataTask = [self kz_uploadTaskWithRequest:request fromFile:fileURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        [self addLogWithURLRequest:request fromFile:fileURL data:data response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

- (NSURLSessionUploadTask *)kz_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionUploadTask *dataTask = nil;
    
    dataTask = [self kz_uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        [self addLogWithURLRequest:request fromData:bodyData data:data response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

/*
 * download task convenience methods.  When a download successfully
 * completes, the NSURL will point to a file that must be read or
 * copied during the invocation of the completion routine.  The file
 * will be removed automatically.
 */
- (NSURLSessionDownloadTask *)kz_downloadTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionDownloadTask *dataTask = nil;
    
    dataTask = [self kz_downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(location, response, error) : nil;
        
        [self addLogWithURLRequest:request location:location response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

- (NSURLSessionDownloadTask *)kz_downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionDownloadTask *dataTask = nil;
    
    dataTask = [self kz_downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(location, response, error) : nil;
        
        [self addLogWithURL:url location:location response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}

- (NSURLSessionDownloadTask *)kz_downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];
    
    __block NSURLSessionDownloadTask *dataTask = nil;
    
    dataTask = [self kz_downloadTaskWithResumeData:resumeData completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(location, response, error) : nil;
        
        [self addLogWithResumeData:resumeData location:location response:response error:error requestTime:requestTime];
    }];
    
    return dataTask;
}


#pragma mark - add logs
- (void)addLogWithURLRequest:(NSURLRequest *)request
                        data:(NSData *)data
                    response:(id)response
                       error:(NSError *)error
                 requestTime:(double)requestTime {
    
    NSString *urlstr = [[request URL] absoluteString];
    NSDictionary *headers = [request allHTTPHeaderFields];
    NSString *parameters = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}

- (void)addLogWithURL:(NSURL *)url
                 data:(NSData *)data
             response:(id)response
                error:(NSError *)error
          requestTime:(double)requestTime {
    
    NSString *urlstr = [url absoluteString];
    NSDictionary *headers = nil;
    NSString *parameters = nil;
    NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}

- (void)addLogWithURLRequest:(NSURLRequest *)request
                    fromFile:(NSURL *)fromFile
                        data:(NSData *)data
                    response:(id)response
                       error:(NSError *)error
                 requestTime:(double)requestTime {
    
    NSString *urlstr = [[request URL] absoluteString];
    NSDictionary *headers = [request allHTTPHeaderFields];
    NSString *parameters = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}

- (void)addLogWithURLRequest:(NSURLRequest *)request
                    fromData:(NSData *)fromData
                        data:(NSData *)data
                    response:(id)response
                       error:(NSError *)error
                 requestTime:(double)requestTime {
    
    NSString *urlstr = [[request URL] absoluteString];
    NSDictionary *headers = [request allHTTPHeaderFields];
    NSString *parameters = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}

- (void)addLogWithURLRequest:(NSURLRequest *)request
                    location:(NSURL *)location
                    response:(id)response
                       error:(NSError *)error
                 requestTime:(double)requestTime {
    
    NSString *urlstr = [[request URL] absoluteString];
    NSDictionary *headers = [request allHTTPHeaderFields];
    NSString *parameters = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    NSString *responseObject = [location absoluteString];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}


- (void)addLogWithURL:(NSURL *)url
             location:(NSURL *)location
             response:(id)response
                error:(NSError *)error
          requestTime:(double)requestTime {
    
    NSString *urlstr = [url absoluteString];
    NSDictionary *headers = nil;
    NSString *parameters = nil;
    NSString *responseObject = [location absoluteString];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}


- (void)addLogWithResumeData:(NSData *)resumeData
                    location:(NSURL *)location
                    response:(id)response
                       error:(NSError *)error
                 requestTime:(double)requestTime {
    
    NSString *urlstr = nil;
    NSDictionary *headers = nil;
    NSString *parameters = nil;
    NSString *responseObject = [location absoluteString];
    
    [self formatLogWithURL:urlstr headers:headers parameters:parameters responseObject:responseObject error:error requestTime:requestTime];
}

#pragma mark - format
- (void)formatLogWithURL:(NSString *)url
                  headers:(NSDictionary *)headers
               parameters:(id)parameters
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
        logging = [NSString stringWithFormat:@"NSURLSession <<<===\nurl:%@\natTime:%@ interval:%f\nheaderFields:%@\nparameters:%@\nerror:%@\n NSURLSession ===>>>", url, atTime, interval, headers, parameters, error];
    } else {
        logging = [NSString stringWithFormat:@"NSURLSession <<<===\nurl:%@\natTime:%@ interval:%f\nheaderFields:%@\nparameters:%@\nresponse:%@\n NSURLSession ===>>>", url, atTime, interval, headers, parameters, responseObject];
    }
    
    TLOG(@"%@", logging);
}

@end
