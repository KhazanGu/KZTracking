//
//  NSURLSession+Tracking.m
//  AFNetworking
//
//  Created by Khazan on 2019/11/12.
//

#import "NSURLSession+Tracking.h"
#import "KZTrackingMacros.h"
#import "SwizzleManager.h"

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
        
        NSString *url = [[request URL] absoluteString];
        NSString *parameters = [[NSString alloc] initWithData:[request HTTPBody] encoding:NSUTF8StringEncoding];
        NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [self addLogWithURL:url parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
    }];
    
    return dataTask;
}
- (NSURLSessionDataTask *)kz_dataTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];

    __block NSURLSessionDataTask *dataTask = nil;
    
    dataTask = [self kz_dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        NSString *urlstr = [url absoluteString];
        NSString *parameters = nil;
        NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [self addLogWithURL:urlstr parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
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
        
        NSString *url = [[request URL] absoluteString];
        NSString *parameters = nil;
        NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [self addLogWithURL:url parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
    }];
    
    return dataTask;
}
- (NSURLSessionUploadTask *)kz_uploadTaskWithRequest:(NSURLRequest *)request fromData:(nullable NSData *)bodyData completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];

    __block NSURLSessionUploadTask *dataTask = nil;
    
    dataTask = [self kz_uploadTaskWithRequest:request fromData:bodyData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(data, response, error) : nil;
        
        NSString *url = [[request URL] absoluteString];
        NSString *parameters = nil;
        NSString *responseObject = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        [self addLogWithURL:url parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
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
        
        NSString *url = [[request URL] absoluteString];
        NSString *parameters = nil;
        NSString *responseObject = [location absoluteString];
        
        [self addLogWithURL:url parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
    }];
    
    return dataTask;
}
- (NSURLSessionDownloadTask *)kz_downloadTaskWithURL:(NSURL *)url completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];

    __block NSURLSessionDownloadTask *dataTask = nil;
    
    dataTask = [self kz_downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(location, response, error) : nil;
        
        NSString *urlstr = [url absoluteString];
        NSString *parameters = nil;
        NSString *responseObject = [location absoluteString];
        
        [self addLogWithURL:urlstr parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
    }];
    
    return dataTask;
}
- (NSURLSessionDownloadTask *)kz_downloadTaskWithResumeData:(NSData *)resumeData completionHandler:(void (^)(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler {
    
    NSTimeInterval requestTime = [[NSDate date] timeIntervalSince1970];

    __block NSURLSessionDownloadTask *dataTask = nil;
    
    dataTask = [self kz_downloadTaskWithResumeData:resumeData completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler ? completionHandler(location, response, error) : nil;
        
        NSString *url = nil;
        NSString *parameters = nil;
        NSString *responseObject = [location absoluteString];
        
        [self addLogWithURL:url parameters:parameters task:dataTask responseObject:responseObject error:error requestTime:requestTime];
    }];
    
    return dataTask;
}



- (void)addLogWithURL:(NSString *)url parameters:(id)parameters task:(NSURLSessionTask *)task responseObject:(id)responseObject error:(NSError *)error requestTime:(double)requestTime {
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

@end
